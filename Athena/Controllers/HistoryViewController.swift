import UIKit
import CoreData

class HistoryViewController: UIViewController {
    var store: RussianStore = RussianStore()
    var lastIndex: IndexPath!
    var fetchedResultsController: NSFetchedResultsController<Word>!

    var tableView: UITableView!

    override func viewDidLoad() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

        initFetchedResultsController()
        initTableView()
        initGradientColor(colors: [AthenaPalette.lightBlue.cgColor, AthenaPalette.lightPink.cgColor])
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
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    func initTableView() {
        print(tabBarController?.tabBar.frame.height)
        tableView = UITableView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height - 20 - (tabBarController?.tabBar.frame.height)!))
        tableView.sectionHeaderHeight = 50
        tableView.backgroundColor = UIColor.clear
        tableView.register(HistoryCell.self, forCellReuseIdentifier: "HistoryCell")

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
    }

    func initGradientColor(colors: [CGColor]) {
        let gl = CAGradientLayer()
        gl.frame = self.view.frame
        gl.colors = colors
        gl.locations = [0.0, 1.0]
//        let bgView = UIView.init(frame: self.tableView.frame)
        view.layer.insertSublayer(gl, at: 0)
//        self.tableView.backgroundView = bgView
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HistoryHeaderView()
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            headerView.titleLabel.text = sectionInfo.name
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.name
        }

        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellOptional = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell
        let word = fetchedResultsController.object(at: indexPath)

        guard let cell =  cellOptional else {
            fatalError("HistoryCell not found.")
        }

        let correct = Float(word.correctCount)
        let total = max(Float(word.correctCount) + Float(word.incorrectCount), 1)
        let accuracy = correct / total
        cell.accuracyLabel.text = getPercentage(number: accuracy)
        cell.nativeLabel.text = word.native
        cell.englishLabel.text = word.english

        let diffInDays = Calendar.current.dateComponents([.day], from: word.lastSeen!, to: Date()).day

        // todo better strength formula
        cell.strengthView.progress = min(1.0, accuracy - (0.01 * Float(diffInDays!) - 5.0))

        return cell
    }

    func getPercentage(number: Float) -> String {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = NumberFormatter.Style.percent
        percentFormatter.minimumFractionDigits = 0
        percentFormatter.maximumFractionDigits = 2

        return percentFormatter.string(from: NSNumber(value: number))!
    }
}

extension HistoryViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        initFetchedResultsController()
        tableView.reloadData()
    }
}
