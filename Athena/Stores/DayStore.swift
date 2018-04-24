import UIKit // To get UIApplication
import CoreData

struct DayStore {
    var context: NSManagedObjectContext!

    var numberOfDays: Int?
    var days: [DayWrapper] = []

    init(numberOfDays: Int?) {
        weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let loadContext = appDelegate?.persistentContainer.viewContext else {
            fatalError("Could not get context")
        }
        context = loadContext
        self.numberOfDays = numberOfDays
        days = getDays(limit: numberOfDays, predicates: nil)
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    func getDays(limit: Int?, predicates: [NSPredicate]?) -> [DayWrapper] {
        let fetchRequestSender = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")

        let lastSort = NSSortDescriptor(key: "date", ascending: false)
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

        var days: [DayWrapper] = []

        do {
            let entities = try context.fetch(fetchRequestSender)

            for entity in entities {
                if let day = entity as? Day {
                    days.append(DayWrapper(day: day))
                }
            }
        } catch {
            print("error executing fetch request: \(error)")
        }

        return days
    }

    mutating func getCurrentDay() -> DayWrapper {

        // Get the current calendar with local time zone
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local

        // Get the start of the day
        let dateFrom = calendar.startOfDay(for: Date())
        let datePredicate = NSPredicate(format: "%@ <= date", dateFrom as NSDate)

        if let day = days.first(where: {$0.day.date! <= dateFrom}) {
           return day
        }

        // Check if current day is in core data
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

        let wrapperCurrent = DayWrapper(day: currentDate)
        days.append(wrapperCurrent)
        saveContext()

        return wrapperCurrent
    }

    func getLastNumberOfDays(number: Int) -> [DayWrapper] {

        // Get the current calendar with local time zone
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local

        // Get the start of the day
        let currentDate = calendar.startOfDay(for: Date())
        let dateFrom = calendar.date(byAdding: .day, value: number, to: currentDate)
        if let date = dateFrom {
            let datePredicate = NSPredicate(format: "%@ <= date", date as NSDate)

            // Check if current day is in core data
            let datesArr = getDays(limit: 1, predicates: [datePredicate])

            return datesArr
        }

        return []
    }
}
