import Foundation
import SwiftyJSON
import CoreData

public enum Language: String {
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

    // Return all the words that follow the given predicates
    func getWordsFromTopic(predicates: [NSPredicate]) -> [Word] {
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and,
                                            subpredicates: predicates)
        let fetchRequestSender = NSFetchRequest<NSFetchRequestResult>(entityName: "Word")
        fetchRequestSender.predicate = predicate

        var words: [Word] = []

        do {
            let entities = try context.fetch(fetchRequestSender)

            for e in entities {
                if let word = e as? Word {
                    words.append(word)
                }
            }
        } catch {
            print("error executing fetch request: \(error)")
        }

        return words
    }

    func getRandomLearnedWordFromTopic(topicName: String, learned: Bool) -> Word? {
        let namePredicate = NSPredicate(format: "topic.name == %@", topicName)
        let learnedPredicate = NSPredicate(format: "learned == %@", NSNumber(value: learned))
        let predicates = [namePredicate, learnedPredicate]

        let words = getWordsFromTopic(predicates: predicates)

        if words.count < 1 {
            return nil
        }

        let randomIndex = Int(arc4random_uniform(UInt32(words.count)))
        return words[randomIndex]
    }

    func getRandomWords(topicName: String, word: Word, amount: Int) -> [Word] {
        var words: [Word] = [word]
        var indexes: [Int] = []

        let namePredicate = NSPredicate(format: "topic.name == %@", topicName)
        let learnedPredicate = NSPredicate(format: "learned == %@", NSNumber(value: true))
        let notLearnedPredicate = NSPredicate(format: "learned == %@", NSNumber(value: false))

        var predicates = [namePredicate, learnedPredicate]
        var learnedWords = getWordsFromTopic(predicates: predicates)

        // If the given word is learned we want to acocunt for it
        if let index = learnedWords.index(of: word) {
            indexes.append(index)
        }

        // Get random words while we don't have 4 and wordsLearned still has unused words
        while words.count < amount && indexes.count < learnedWords.count {
            let randomIndex = Int(arc4random_uniform(UInt32(learnedWords.count)))
            let randomWord = learnedWords[randomIndex]

            if !indexes.contains(randomIndex) && !words.contains {$0.native == randomWord.native} {
                words.append(randomWord)
                indexes.append(randomIndex)
            }
        }

        // Need to reset indexes for not learned
        indexes = []

        predicates = [namePredicate, notLearnedPredicate]
        var notLearned = getWordsFromTopic(predicates: predicates)

        // If the given word is not learned we want to acocunt for it
        if let index = notLearned.index(of: word) {
            indexes.append(index)
        }

        // Get random words while we don't have 4 and wordsToLearn still  has unused words
        while words.count < amount && indexes.count < notLearned.count {
            let randomIndex = Int(arc4random_uniform(UInt32(notLearned.count)))
            let randomWord = notLearned[randomIndex]

            if !indexes.contains(randomIndex) && !words.contains {$0.native == randomWord.native} {
                words.append(randomWord)
                indexes.append(randomIndex)
            }
        }

        return words
    }

    func getNativeString(words: [Word]) -> [String] {
        var wordsString: [String] = []
        for word in words {
            wordsString.append(word.native!)
        }
        return wordsString
    }

    func getEnglishString(words: [Word]) -> [String] {
        var wordsString: [String] = []
        for word in words {
            wordsString.append(word.english!)
        }
        return wordsString
    }

    func learnedNewWord(topic: Topic, word: Word?) {
        topic.learnedWordsCount += 1
        if let word = word {
            word.learned = true
        }
    }

    func getTopicPercentageComplete(topic: Topic) -> Float {
        return Float(topic.learnedWordsCount) / Float(topic.totalWordsCount)
    }
}
