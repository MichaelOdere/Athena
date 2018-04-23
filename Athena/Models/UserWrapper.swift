import Foundation
import CoreData

// A wrapper for the core data object User that encapsulates the needed functionality
struct UserWrapper {
    var user: User!
    var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        self.user = getUser()

    }

    func getUser() -> User {
        let fetchRequestSender = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        // check to see if we already have a user. If we do return the user
        do {
            let entities = try context.fetch(fetchRequestSender)
            if entities.count > 0 {
                if let user = entities[0] as? User {
                    return user
                }
            }
        } catch {
            print("error executing fetch request: \(error)")
        }

        // If we do not already have a user that create a new one
        let newUser = User(context: context)
        newUser.mostWordsLearnedInADay = 0
        newUser.longestStreak = 0
        newUser.currentStreak = 0

        return newUser
    }
}
