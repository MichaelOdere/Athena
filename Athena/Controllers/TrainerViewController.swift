import UIKit
import CoreData

class TrainerViewController: UIViewController {
    let store: RussianStore = RussianStore()
    var fetchedResultsController: NSFetchedResultsController<Word>!
    var spellView: SpellView!

    override func viewDidLoad() {
        initGradientColor()
        initFetchedResultsController()
        initSpellView()
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

    func initSpellView() {
        spellView = SpellView(frame: view.frame)
        guard let words = fetchedResultsController.fetchedObjects else {
            return
        }

        if words.count > 0 {
            spellView.word = words[0]
        }

        view.addSubview(spellView)
    }

    func initGradientColor() {
        let gl = CAGradientLayer()
        gl.frame = self.view.frame
        gl.colors = [AthenaPalette.yankeesBlue.cgColor, AthenaPalette.lightPink.cgColor]
        gl.locations = [0.0, 1.0]
        view.layer.insertSublayer(gl, at: 0)
    }
}
