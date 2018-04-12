import UIKit
import CoreData

class HistoryViewController: UITableViewController {
    var store: RussianStore = RussianStore()
    var colors = [AthenaPalette.parisGreen,
                  AthenaPalette.maximumBlue,
                  AthenaPalette.lightPink,
                  AthenaPalette.rasberryPink,
                  AthenaPalette.maximumRed]

    var lastIndex: IndexPath!
    var fetchedResultsController: NSFetchedResultsController<Word>!

    override func viewDidLoad() {
        initFetchedResultsController()
        initTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let index = lastIndex else {
            return
        }
        tableView.reloadRows(at: [index], with: .none)
    }

    func initFetchedResultsController() {
        let topicRequests: NSFetchRequest<Word> = Word.fetchRequest()
        topicRequests.predicate = NSPredicate(format: "learned == %@", NSNumber(value: true))

//        let sortDescriptor = NSSortDescriptor(key: "lastSceen", ascending: false)
        let topicSort = NSSortDescriptor(key: "topic.level", ascending: false)
        let englishSort = NSSortDescriptor(key: "english", ascending: false)
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

    func initTableView() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//
//        guard let tabHeight = self.tabBarController?.tabBar.frame.height else {
//            fatalError("tabbar height not found.")
//        }
//
//        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - tabHeight)
//        tableView = UITableView(frame: frame)
//        view.addSubview(tableView)
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.bounces = false
//        tableView.rowHeight = 120
        tableView.sectionHeaderHeight = 50
//        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(HistoryCell.self, forCellReuseIdentifier: "HistoryCell")
    }
}

extension HistoryViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.name
        }

        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        lastIndex = indexPath
//        let vc = LearnTopicViewController()
//        let topic = fetchedResultsController.object(at: indexPath)
//        vc.topic = TopicWrapper(topic: topic, context: store.context)
//        vc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(vc, animated: true)
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellOptional = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell
        let word = fetchedResultsController.object(at: indexPath)

        guard let cell =  cellOptional else {
            fatalError("HistoryCell not found.")
        }
        let correct = Float(word.correctCount)
        let total = max(Float(word.correctCount) + Float(word.incorrectCount), 1)
        let accuracy = correct / total
        cell.accuracyLabel.text = "\(accuracy)"
        cell.nativeLabel.text = word.native
        cell.englishLabel.text = word.english
//        cell.progress.progress = Float(topic.learnedWordsCount) / Float(topic.totalWordsCount)

        cell.backgroundColor = colors[indexPath.row % colors.count]
        return cell
    }
}
