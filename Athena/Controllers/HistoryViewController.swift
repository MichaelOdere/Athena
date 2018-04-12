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

    func initFetchedResultsController() {
        let topicRequests: NSFetchRequest<Word> = Word.fetchRequest()
        topicRequests.predicate = NSPredicate(format: "learned == %@", NSNumber(value: true))

//        let sortDescriptor = NSSortDescriptor(key: "lastSceen", ascending: false)
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        tableView.sectionHeaderHeight = 50
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        // TODO better learning formula
        cell.strengthView.progress = accuracy - 0.01 * Float(diffInDays!)

        cell.backgroundColor = colors[indexPath.row % colors.count]
        return cell
    }

    func getPercentage(number: Float) -> String {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = NumberFormatter.Style.percent
        percentFormatter.minimumFractionDigits = 0
        percentFormatter.maximumFractionDigits = 2

        return percentFormatter.string(from: NSNumber(value: number))!
    }

//    func getDaysSince(lastSceen: Date) -> Int {
//        let currentCalendar = Calendar.current
//
//        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
//        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
//
//        return end - start
//    }
}

extension HistoryViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        initFetchedResultsController()
        tableView.reloadData()
    }
}
