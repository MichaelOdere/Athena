import Foundation
import SwiftyJSON

struct RussianStore {
    var topics: [Topic] = []
    let defaults = UserDefaults.standard

    init() {
        populateTopics()
        // Reset defaults so that we start with clean slate each time for testing
//        resetProgress()
//        resetView()
    }

    mutating func populateTopics() {
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
                if let topic = Topic(json: topicJson) {
                    topicSetupFromDefaults(topic: topic)
                    topics.append(topic)
                }
            }
        } catch {
            print(error)
        }
    }

    func topicSetupFromDefaults(topic: Topic) {
        setWordsLearnedOnInit(topic: topic)
        setLastViewOnInit(topic: topic)
    }

    func setWordsLearnedOnInit(topic: Topic) {
        let progress = defaults.integer(forKey: topic.getProgressKey())
        for count in 0..<topic.wordsToLearn.count {
            if count == progress {
                break
            }
            topic.wordsLearned.append(topic.wordsToLearn[0])
            topic.wordsToLearn.remove(at: 0)
        }
    }

    func setLastViewOnInit(topic: Topic) {
        guard let lastView = defaults.string(forKey: topic.getLastViewKey()) else {
            print("\(topic.getLastViewKey()) not found")
            return
        }

        guard let lastTopicView = LearnView(rawValue: lastView) else {
            print("\(lastView) not valid LearnView type")
            return
        }

        topic.lastTopicView = lastTopicView
    }

    func resetProgress() {
        for topic in topics {
            defaults.set(0, forKey: topic.getProgressKey())
        }
    }

    func resetView() {
        for topic in topics {
            defaults.set(LearnView.introductionToWord.rawValue, forKey: topic.getLastViewKey())
            topic.lastTopicView = .introductionToWord
        }
    }
}
