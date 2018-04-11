import Foundation
import CoreData

// A wrapper for the core data object Topic that encapsulates the needed functionality
struct TopicWrapper {
    var topic: Topic
    var context: NSManagedObjectContext
    var name: String

    init(topic: Topic, context: NSManagedObjectContext) {
        self.topic = topic
        self.context = context

        if let name = topic.name {
            self.name = name
        } else {
            name = ""
        }
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    func learnedNewWord(word: Word?) {
        topic.learnedWordsCount += 1
        if let word = word {
            word.learned = true
        }
    }

    func getPercentageComplete() -> Float {
        return Float(topic.learnedWordsCount) / Float(topic.totalWordsCount)
    }

}

// MARK: - Get words
extension TopicWrapper {

    // Get next word that has not been learned
    func getNextWord() -> Word? {
        let namePredicate = NSPredicate(format: "topic.name == %@", name)
        let notLearnedPredicate = NSPredicate(format: "learned == %@", NSNumber(value: false))
        let predicates = [namePredicate, notLearnedPredicate]

        let words = getWordsFromTopic(predicates: predicates)

        if words.count > 0 {
            return words[0]
        }

        return nil
    }

    // Get all the words that follow the given predicates
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

    // Get random word given learned or not
    func getRandomWord(learned: Bool) -> Word? {
        let namePredicate = NSPredicate(format: "topic.name == %@", name)
        let learnedPredicate = NSPredicate(format: "learned == %@", NSNumber(value: learned))
        let predicates = [namePredicate, learnedPredicate]

        let words = getWordsFromTopic(predicates: predicates)

        if words.count < 1 {
            return nil
        }

        let randomIndex = Int(arc4random_uniform(UInt32(words.count)))
        return words[randomIndex]
    }

    // Get random learned words
    // If not enough learned words, get the remainder from words not yet learned
    func getRandomWords(word: Word, amount: Int) -> [Word] {
        var words: [Word] = [word]
        var indexes: [Int] = []

        let namePredicate = NSPredicate(format: "topic.name == %@", name)
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

    // Get all native string from a list of words
    func getNativeString(words: [Word]) -> [String] {
        var wordsString: [String] = []
        for word in words {
            wordsString.append(word.native!)
        }
        return wordsString
    }

    // Get all english string from a list of words
    func getEnglishString(words: [Word]) -> [String] {
        var wordsString: [String] = []
        for word in words {
            wordsString.append(word.english!)
        }
        return wordsString
    }
}

// MARK: - Can show views functionality
extension TopicWrapper {
    func canShowIntroductionToWordView() -> Bool {
        return topic.learnedWordsCount < topic.totalWordsCount
    }

    func canShowDragFiveCorrectView() -> Bool {
        return topic.totalWordsCount >= 4 && topic.learnedWordsCount > 0
    }

    func canShowDragThreeCorrectView() -> Bool {
        return topic.totalWordsCount >= 2 && topic.learnedWordsCount > 0
    }
}
