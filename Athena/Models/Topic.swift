//import SwiftyJSON
//
//public enum Language: String {
//    case english
//    case hebrew
//    case russian
//    case spanish
//}
//
//class Topic {
//    var name: String
//    var icon: String
//    var language: Language
//    var wordsLearned: [Word]
//    var wordsToLearn: [Word]
//    var lastTopicView: LearnView {
//        didSet {
//            let defaults = UserDefaults.standard
//            defaults.set(lastTopicView.rawValue, forKey: getLastViewKey())
//        }
//    }
//
//    init(name: String, icon: String, language: Language, wordsLearned: [Word], wordsToLearn: [Word],
//         lastTopicView: LearnView) {
//
//        self.name = name
//        self.icon = icon
//        self.language = language
//        self.wordsLearned = wordsLearned
//        self.wordsToLearn = wordsToLearn
//        self.lastTopicView = lastTopicView
//    }
//
//    func incrementProgress() {
//        let defaults = UserDefaults.standard
//        let current = defaults.integer(forKey: getProgressKey())
//        defaults.set(current + 1, forKey: getProgressKey())
//
//        if self.wordsToLearn.count > 0 {
//            self.wordsLearned.append(self.wordsToLearn[0])
//            self.wordsToLearn.remove(at: 0)
//        }
//    }
//
//    func getProgressKey() -> String {
//        return "\(self.name)-progress"
//    }
//
//    func getLastViewKey() -> String {
//        return "\(self.name)-last-view"
//    }
//
//    func getRandomWord() -> Word {
//        if wordsLearned.count > 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(self.wordsLearned.count)))
//            let randomWord = self.wordsLearned[randomIndex]
//            return randomWord
//        }
//
//        let randomIndex = Int(arc4random_uniform(UInt32(self.wordsToLearn.count)))
//        let randomWord = self.wordsToLearn[randomIndex]
//        return randomWord
//    }
//
//    // Get random words from words learned
//    // If words learned does not have enough, get the remainder from words not yet learned
//    func getRandomWords(word: Word, amount: Int) -> [Word] {
//        var words: [Word] = [word]
//        var indexes: [Int] = []
//
//        if let index = self.wordsLearned.index(where: {$0.english == word.english}) {
//            indexes.append(index)
//        }
//
//        // Get random words while we don't have 4 and wordsLearned still has unused words
//        while words.count < amount && indexes.count < self.wordsLearned.count {
//            let randomIndex = Int(arc4random_uniform(UInt32(self.wordsLearned.count)))
//            let randomWord = self.wordsLearned[randomIndex]
//
//            if !indexes.contains(randomIndex) && !words.contains {$0.native == randomWord.native} {
//                words.append(randomWord)
//                indexes.append(randomIndex)
//            }
//        }
//
//        indexes = []
//
//        if let index = self.wordsToLearn.index(where: {$0.english == word.english}) {
//            indexes.append(index)
//        }
//
//        // Get random words while we don't have 4 and wordsToLearn still  has unused words
//        while words.count < amount && indexes.count < self.wordsToLearn.count {
//            let randomIndex = Int(arc4random_uniform(UInt32(self.wordsToLearn.count)))
//            let randomWord = self.wordsToLearn[randomIndex]
//
//            if !indexes.contains(randomIndex) && !words.contains {$0.native == randomWord.native} {
//                words.append(randomWord)
//                indexes.append(randomIndex)
//            }
//        }
//
//        return words
//    }
//
//    func getNativeString(words: [Word]) -> [String] {
//        var wordsString: [String] = []
//        for word in words {
//            wordsString.append(word.native)
//        }
//        return wordsString
//    }
//
//    func getEnglishString(words: [Word]) -> [String] {
//        var wordsString: [String] = []
//        for word in words {
//            wordsString.append(word.english)
//        }
//        return wordsString
//    }
//
//    func getTransliterationString(words: [Word]) -> [String] {
//        var wordsString: [String] = []
//        for word in words {
//            wordsString.append(word.transliteration)
//        }
//        return wordsString
//    }
//
//    func canShowIntroductionToWordView() -> Bool {
//        return self.wordsToLearn.count > 0
//    }
//
//    func canShowDragFiveCorrectView() -> Bool {
//        return self.getWordCount() >= 4 && self.wordsLearned.count > 0
//    }
//
//    func canShowDragThreeCorrectView() -> Bool {
//        return self.getWordCount() >= 2 && self.wordsLearned.count > 0
//    }
//
//    func getPercentageComplete() -> Float {
//        return Float(wordsLearned.count) / Float(wordsLearned.count + wordsToLearn.count)
//    }
//
//    func getWordCount() -> Int {
//        return wordsToLearn.count + wordsLearned.count
//    }
//
//    func resetUserDefaults() {
//        let defaults = UserDefaults.standard
//
//        // Reset progress
//        defaults.set(0, forKey: self.getProgressKey())
//
//        // Reset the last view the user was on
//        defaults.set(LearnView.introductionToWord.rawValue, forKey: self.getLastViewKey())
//        self.lastTopicView = .introductionToWord
//    }
//}
//
//extension Topic {
//    convenience init?(json: JSON) {
//        guard let name = json["name"].string else {
//            print("Error parsing game object for key: name")
//            return nil
//        }
//
//        guard let languageStr = json["language"].string else {
//            print("Error parsing game object for key: language")
//            return nil
//        }
//
//        guard let language = Language(rawValue: languageStr) else {
//            print("Error creating Language Enum from rawValue")
//            return nil
//        }
//
//        guard let icon = json["icon"].string else {
//            print("Error parsing game object for key: icon")
//            return nil
//        }
//
//        guard let wordsData = json["wordsToLearn"].array else {
//            print("Error parsing game object for key: wordsToLearn")
//            return nil
//        }
//
//        var words: [Word] = []
//        for wordJson in wordsData {
//            if let word = Word(json: wordJson) {
//                words.append(word)
//            }
//        }
//
//        // Initialize words learned to empty and load what has been learned from CoreData
//        self.init(name: name, icon: icon, language: language, wordsLearned: [], wordsToLearn: words,
//                  lastTopicView: .introductionToWord)
//    }
//}
