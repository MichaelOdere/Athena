import Foundation
import SwiftyJSON

struct RussianStore {
    var topics: [Topic] = []

    init() {
        populateTopics()
        // Reset defaults so that we start with clean slate each time for testing
        resetDefaults()
        setWordsLearnedOnInit()
    }

    mutating func populateTopics() {
        guard let url = Bundle.main.url(forResource: "Russian", withExtension: "json") else {
            fatalError("Cannot find Russian.json")
        }

        do {
            let data = try Data(contentsOf: url)
            let jsonData = try JSON(data)

            guard let topicsData = jsonData["topics"].array else {
                fatalError("Cannot parse Russian topics data")
            }

            for topicJson in topicsData {
                if let topic = Topic(json: topicJson) {
                    topics.append(topic)
                }
            }
        } catch {
            print(error)
        }
    }

    func setWordsLearnedOnInit() {
        let defaults = UserDefaults.standard
        for topic in topics {
            let progress = defaults.integer(forKey: topic.name)
            for count in 0..<topic.wordsToLearn.count {
                if count == progress {
                    break
                }
                topic.wordsLearned.append(topic.wordsToLearn[0])
                topic.wordsToLearn.remove(at: 0)
            }
        }
    }

    func resetDefaults() {
        let defaults = UserDefaults.standard
        for topic in topics {
            defaults.set(0, forKey: topic.name)
        }
    }

}
