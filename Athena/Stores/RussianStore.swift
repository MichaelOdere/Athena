import Foundation
import SwiftyJSON

struct RussianStore {
    var topics: [Topic] = []

    init() {
        populateTopics()
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
            
            
            for topicJson in topicsData{
                if let topic = Topic(json: topicJson) {
                    topics.append(topic)
                }
            }
            
        } catch {
            print(error)
        }
    }
}
