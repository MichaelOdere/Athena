import SwiftyJSON

class Topic {
    var name: String
    var icon: String
    var wordsLearned: [Word]
    var wordsToLearn: [Word]

    init(name: String, icon: String, wordsLearned: [Word], wordsToLearn: [Word]) {
        self.name = name
        self.icon = icon
        self.wordsLearned = wordsLearned
        self.wordsToLearn = wordsToLearn
    }

    func getPercentageComplete() -> Float {
        return Float(wordsLearned.count) / Float(wordsLearned.count + wordsToLearn.count)
    }
}

extension Topic {
    convenience init?(json: JSON) {
        guard let name = json["name"].string else {
            print("Error parsing game object for key: name")
            return nil
        }

        guard let icon = json["icon"].string else {
            print("Error parsing game object for key: icon")
            return nil
        }

        guard let wordsData = json["words"].array else {
            print("Error parsing game object for key: language")
            return nil
        }

        var words: [Word] = []
        for wordJson in wordsData {
            if let word = Word(json: wordJson) {
                words.append(word)
            }
        }

        // Initialize words learned to empty and load what has been learned from CoreData
        self.init(name: name, icon: icon, wordsLearned: [], wordsToLearn: words)
    }

}
