import Foundation
import CoreData

// A wrapper for the core data object Day that encapsulates the needed functionality
struct DayWrapper {
    var day: Day

    init(day: Day) {
        self.day = day
    }

    func updateAfterResult(result: ResultOfLearn) {
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
