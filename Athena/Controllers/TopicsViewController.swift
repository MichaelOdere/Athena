import UIKit
import CoreData

class TopicsViewController: UIViewController {
    var tableView: UITableView!
    let russianStore: RussianStore = RussianStore()
    let dayStore: DayStore = DayStore(numberOfDays: nil)

    var colors = [AthenaPalette.parisGreen,
                  AthenaPalette.maximumBlue,
                  AthenaPalette.lightPink,
                  AthenaPalette.rasberryPink,
                  AthenaPalette.maximumRed]

    var lastIndex: IndexPath!
    var fetchedResultsController: NSFetchedResultsController<Topic>!

    override func viewDidLoad() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        initFetchedResultsController()
        initTableView()
        scrollToBottom()
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let index = lastIndex else {
            return
        }
        tableView.reloadRows(at: [index], with: .none)
    }

    func initFetchedResultsController() {
        let topicRequests: NSFetchRequest<Topic> = Topic.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "level", ascending: false)
        topicRequests.sortDescriptors = [sortDescriptor]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: topicRequests,
                                                              managedObjectContext: russianStore.context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
//        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    func initTableView() {
        guard let tabHeight = self.tabBarController?.tabBar.frame.height else {
            fatalError("tabbar height not found.")
        }

        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - tabHeight)
        tableView = UITableView(frame: frame)
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.bounces = false
        tableView.rowHeight = 120
        tableView.sectionHeaderHeight = 0.0
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(TopicCell.self, forCellReuseIdentifier: "TopicCell")
    }

    func scrollToBottom() {
        DispatchQueue.main.async {
            guard let count = self.fetchedResultsController.fetchedObjects?.count else {
                print("Can't get fetchedResultsController.fetchedObjects")
                return
            }

            if count < 1 {
                return
            }

            let indexPath = IndexPath(row: count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
}

extension TopicsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }

        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastIndex = indexPath
        let vc = LearnTopicViewController()
        let topic = fetchedResultsController.object(at: indexPath)
        vc.topic = TopicWrapper(topic: topic, context: russianStore.context)
        vc.dayStore = dayStore
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellOptional = tableView.dequeueReusableCell(withIdentifier: "TopicCell") as? TopicCell
        let topic = fetchedResultsController.object(at: indexPath)

        guard let cell =  cellOptional else {
            fatalError("TopicCell not found.")
        }
        cell.title.text = topic.name
        cell.progress.progress = Float(topic.learnedWordsCount) / Float(topic.totalWordsCount)

        cell.backgroundColor = colors[indexPath.row % colors.count]
        return cell
    }
}
