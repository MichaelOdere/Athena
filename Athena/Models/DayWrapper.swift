import Foundation
import CoreData

// A wrapper for the core data object User that encapsulates the needed functionality
struct DayWrapper {
    var days: [Day] = []
    // Number of days wanted. Days will be retrieved in order of most recent
    var numberOfDays: Int?
    var context: NSManagedObjectContext

    init(context: NSManagedObjectContext, numberOfDays: Int) {
        self.context = context
        self.numberOfDays = numberOfDays
        self.days = getDays(limit: numberOfDays, predicates: nil)
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    func getDays(limit: Int?, predicates: [NSPredicate]?) -> [Day] {
        let fetchRequestSender = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")

        let lastSort = NSSortDescriptor(key: "lastSceen", ascending: false)
        fetchRequestSender.sortDescriptors = [lastSort]

        // If we have a limit set it. If not set no limit
        if let limit = limit {
            fetchRequestSender.fetchLimit = limit
        }

        // If we have predicates set them. If not set nothing
        if let nonOptionalPredicates = predicates {
            let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and,
                                                subpredicates: nonOptionalPredicates)
            fetchRequestSender.predicate = predicate
        }

        var days: [Day] = []

        do {
            let entities = try context.fetch(fetchRequestSender)

            for entity in entities {
                if let day = entity as? Day {
                    days.append(day)
                }
            }
        } catch {
            print("error executing fetch request: \(error)")
        }

        return days
    }

    mutating func getCurrentDay() -> Day {
        // Check if current day is in days list
        if let index = days.index(where: {$0.date == Date() }) {
            return days[index]
        }

        // Check if current day is in core data but not in days
        // Get the current calendar with local time zone
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local

        // Get the start of the day
        let dateFrom = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
        let datePredicate = NSPredicate(format: "%@ <= date", dateFrom as NSDate)

        let currentDateArr = getDays(limit: 1, predicates: [datePredicate])
        if currentDateArr.count > 0 {
            days.append(currentDateArr[0])
            return currentDateArr[0]
        }

        // If current day does not exist, create it, save it and add it to days list
        let currentDate = Day(context: context)
        currentDate.date = Date()
        currentDate.learnedWords = 0
        currentDate.incorrectWords = 0
        currentDate.correctWords = 0

        saveContext()

        return currentDate
    }

    mutating func updateAfterResult(result: ResultOfLearn) {

        let day = getCurrentDay()

        switch result {
        case .learned(_):
            day.learnedWords += 1
        case .incorrect(_):
            day.incorrectWords += 1
        case .correct(_):
            day.correctWords += 1
        default:
            break
        }
    }
}
