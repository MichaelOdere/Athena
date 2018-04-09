import XCTest
@testable import Athena
import SwiftyJSON

class ModelTests: XCTestCase {

    var topic: Topic!

    override func setUp() {
        super.setUp()
        createTopic()
    }

    func createTopic() {
        let jsonData: [String: Any] = [
            
            "name": "Test",
            "icon": "settings",
            "language": "russian",
            "wordsToLearn": [
                [
                    "english": "Bus",
                    "native": "Автобус",
                    "transliteration": "ahvtohboos"
                ],
                [
                    "english": "Airport",
                    "native": "Аэропорт",
                    "transliteration": "ahehrohpohrt"
                ],
                [
                    "english": "Ticket",
                    "native": "byeelyeht",
                    "transliteration": "byeelyeht"
                ],
                [
                    "english": "Close/near",
                    "native": "Близко",
                    "transliteration": "vyehlohsyeepyehd"
                ]
            ]
        ]
        
        let json = JSON(jsonData)
        
        guard let initTopic = Topic(json: json) else {
            XCTFail("Failed to parse Topic")
            return
        }

        initTopic.resetUserDefaults()
        self.topic = initTopic
    }
    
    override func tearDown() {
        super.tearDown()
        topic = nil
    }

    func testWordJSONInitializing() {
        let jsonData = [
            "english": "d",
            "native": "Д (д)",
            "transliteration": "d"
        ]

        let json = JSON(jsonData)

        guard let word = Word(json: json) else {
            XCTFail("Failed to parse Word")
            return
        }

        XCTAssertEqual(word.english, "d", "Word: Incorrect atribute english")
        XCTAssertEqual(word.native, "Д (д)", "Word: Incorrect atribute native")
        XCTAssertEqual(word.transliteration, "d", "Word: Incorrect atribute transliteration")
    }

    func testTopicJSONInitializing() {

        XCTAssertEqual(topic.name, "Test", "Topic: Incorrect atribute name")
        XCTAssertEqual(topic.icon, "settings", "Topic: Incorrect atribute icon")
        XCTAssertEqual(topic.language, .russian, "Topic: Incorrect language")
        XCTAssertEqual(topic.wordsToLearn.count, 4, "Topic: Incorrect atribute words.count")
    }

    func testTopicCanShow() {
        XCTAssertEqual(topic.canShowIntroductionToWordView(), true)
        XCTAssertEqual(topic.canShowDragFiveCorrectView(), false)
        XCTAssertEqual(topic.canShowDragThreeCorrectView(), false)

        topic.incrementProgress()

        XCTAssertEqual(topic.canShowDragFiveCorrectView(), true)
        XCTAssertEqual(topic.canShowDragThreeCorrectView(), true)

        topic.wordsToLearn.removeAll()
        XCTAssertEqual(topic.canShowDragFiveCorrectView(), false)
    }

    func testGetRandomWords() {
        topic.incrementProgress()

        let randomWord = topic.getRandomWord()
        let randomWords = topic.getRandomWords(word: randomWord, amount: 3)
        XCTAssertEqual(randomWords.count, 3)
    }
}
