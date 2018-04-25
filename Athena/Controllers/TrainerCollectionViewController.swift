import UIKit
import CoreData

class TrainerCollectionViewController: UIViewController {
    let store: RussianStore = RussianStore()
    var fetchedResultsController: NSFetchedResultsController<Word>!
    var spellView: SpellView!
    var flashCardView: FlashCardsView!

    var collectionView: UICollectionView!
    var trainerViewController: TrainerViewController!
    var trainerViews: [TrainerViewProtocol] = []

    override func viewDidLoad() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        initGradientColor()
        initFetchedResultsController()
        initSpellView()
        initFlashCardView()
        initCollectionView()
        initTrainerViewController()
        trainerViews = [spellView, flashCardView]
    }

    func initFetchedResultsController() {
        let topicRequests: NSFetchRequest<Word> = Word.fetchRequest()
        let learned = NSPredicate(format: "learned == %@", NSNumber(value: true))
        let strength = NSPredicate(format: "strength <= %@", NSNumber(value: 0.75))

        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [learned, strength])
        topicRequests.predicate = compound

        let strengthSort = NSSortDescriptor(key: "strength", ascending: true)
        topicRequests.sortDescriptors = [strengthSort]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: topicRequests,
                                                              managedObjectContext: store.context,
                                                              sectionNameKeyPath: "topic.name",
                                                              cacheName: nil)

        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    func initCollectionView() {
        collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: view.frame.height * 0.1,
                                                        width: view.frame.width,
                                                        height: view.frame.height *  0.9),
                                                        collectionViewLayout: TrainerCollectionViewLayout())
        collectionView.register(TrainerCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.clear

        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)
    }

    func initTrainerViewController() {
        trainerViewController = TrainerViewController()
    }

    func initSpellView() {
        spellView = SpellView(frame: view.frame)
    }

    func initFlashCardView() {
        flashCardView = FlashCardsView(frame: view.frame)
    }

    func initGradientColor() {
        let gl = CAGradientLayer()
        gl.frame = self.view.frame
        gl.colors = [AthenaPalette.lightPink.cgColor, AthenaPalette.yankeesBlue.cgColor]
        gl.locations = [0.0, 1.0]
        view.layer.insertSublayer(gl, at: 0)
    }
}

extension TrainerCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var view = trainerViews[indexPath.row]
        if let words = fetchedResultsController.fetchedObjects {
            view.words = words
            view.setup()
        }

        trainerViewController.trainerView = view as? UIView
        trainerViewController.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(trainerViewController, animated: true)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainerViews.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let trainerView = trainerViews[indexPath.row]

        var cell: TrainerCollectionCell!

        if let dqCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                                                                                as? TrainerCollectionCell {
            cell = dqCell
        } else {
            cell = TrainerCollectionCell()
        }

        cell.nameLabel.text = trainerView.name
        return cell
    }
}

extension TrainerCollectionViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        initFetchedResultsController()
    }
}
