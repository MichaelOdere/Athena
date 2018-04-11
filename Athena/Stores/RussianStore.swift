import Foundation
import SwiftyJSON
import CoreData

public enum Language: String {
    case english
    case hebrew
    case russian
    case spanish
}

struct RussianStore {
    let defaults = UserDefaults.standard
    weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    var context: NSManagedObjectContext!

    init() {
        guard let loadContext = appDelegate?.persistentContainer.viewContext else {
            fatalError("Could not get context")
        }
        context = loadContext

        checkForNewData()
        saveContext()
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    func checkForNewData() {

        guard let url = Bundle.main.url(forResource: "Russian", withExtension: "json") else {
            fatalError("Cannot find Russian.json")
        }

        do {
            let data = try Data(contentsOf: url)
            let jsonData = JSON(data)

            guard let topicsData = jsonData.array else {
                fatalError("Cannot parse Russian array")
            }

            for topicJson in topicsData {
                if let topic = createTopic(json: topicJson) {
                    print("found new topic \(String(describing: topic.name))")
                }
            }

        } catch {
            print(error)
        }

    }

    func isTopicInCoreData(name: String, language: String) -> Bool {
        let namePredicate = NSPredicate(format: "name == %@", name)
        let languagePredicate = NSPredicate(format: "language == %@", language)
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and,
                                            subpredicates: [namePredicate, languagePredicate])

        let fetchRequestSender = NSFetchRequest<NSFetchRequestResult>(entityName: "Topic")
        fetchRequestSender.predicate = predicate

        var entitiesCount = 0

        do {
            entitiesCount = try context.count(for: fetchRequestSender)
        } catch {
            print("error executing fetch request: \(error)")
        }

        return entitiesCount > 0
    }

    // Parse the topic from JSON
    func createTopic(json: JSON) -> Topic? {
        let topic = Topic(context: context)

        guard let name = json["name"].string else {
            print("Error parsing game object for key: name")
            return nil
        }

        guard let languageStr = json["language"].string else {
            print("Error parsing game object for key: language")
            return nil
        }

        guard let language = Language(rawValue: languageStr) else {
            print("Error creating Language Enum from rawValue")
            return nil
        }

        guard let level = json["level"].int else {
            print("Error parsing game object for key: level")
            return nil
        }

        guard let icon = json["icon"].string else {
            print("Error parsing game object for key: icon")
            return nil
        }

        guard let wordsData = json["wordsToLearn"].array else {
            print("Error parsing game object for key: wordsToLearn")
            return nil
        }

        // Don't want to add another copy of the same topic
        if isTopicInCoreData(name: name, language: language.rawValue) {
            context.delete(topic)
            return nil
        }

        topic.name = name
        topic.language = language.rawValue
        topic.level = Int16(level)
        topic.icon = icon
        topic.lastTopicView = LearnView.introductionToWord.rawValue
        topic.learnedWordsCount = 0
        topic.totalWordsCount = 0

        for wordJson in wordsData {
            if let word = createWord(json: wordJson) {
                topic.addToWords(word)
                topic.totalWordsCount += 1
            }
        }

        return topic
    }

    // Parse the word from JSON
    func createWord(json: JSON) -> Word? {
        let word = Word(context: context)

        guard let english = json["english"].string else {
            print("Error parsing game object for key: english")
            return nil
        }

        guard let native = json["native"].string else {
            print("Error parsing game object for key: native")
            return nil
        }

        guard let transliteration = json["transliteration"].string else {
            print("Error parsing game object for key: transliteration")
            return nil
        }

        word.english = english
        word.native = native
        word.transliteration = transliteration

        word.learned = false
        word.incorrectCount = 0
        word.correctCount = 0

        return word

    }
}
