import UIKit
import CoreData

class TrainerCollectionViewController: UIViewController {
    let store: RussianStore = RussianStore()
    var fetchedResultsController: NSFetchedResultsController<Word>!
    var spellView: SpellView!

    var collectionView: UICollectionView!
    var trainerViewController: TrainerViewController!
    var trainerViews: [TrainerView] = []

    override func viewDidLoad() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        initGradientColor()
        initFetchedResultsController()
        initSpellView()
        initCollectionView()
        initTrainerViewController()
        trainerViews = [spellView, spellView, spellView]
    }

    func initFetchedResultsController() {
        let topicRequests: NSFetchRequest<Word> = Word.fetchRequest()
        topicRequests.predicate = NSPredicate(format: "learned == %@", NSNumber(value: true))

        //        let lastSort = NSSortDescriptor(key: "lastSceen", ascending: false)
        let topicSort = NSSortDescriptor(key: "topic.level", ascending: true)
        let englishSort = NSSortDescriptor(key: "english", ascending: true)
        topicRequests.sortDescriptors = [topicSort, englishSort]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: topicRequests,
                                                              managedObjectContext: store.context,
                                                              sectionNameKeyPath: "topic.name",
                                                              cacheName: nil)

//        fetchedResultsController.delegate = self

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
        guard let words = fetchedResultsController.fetchedObjects else {
            return
        }

        if words.count > 0 {
            spellView.word = words[0]
        }

//        view.addSubview(spellView)
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
        let view = trainerViews[indexPath.row]
        trainerViewController.trainerView = view
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
