import XCTest
@testable import Athena
import SwiftyJSON

class ModelTests: XCTestCase {

    var store: RussianStore!

    override func setUp() {
        super.setUp()
        store = RussianStore()
    }

    override func tearDown() {
        super.tearDown()
        store = nil
    }

    func testWordJSONInitializing() {
        let jsonData = [
            "english": "d",
            "native": "Д (д)",
            "language": "russian",
            "transliteration": "d",
            "audioFile": "nil"
        ]

        let json = JSON(jsonData)

        guard let word = Word(json: json) else {
            XCTFail("Failed to parse Word")
            return
        }

        XCTAssertEqual(word.english, "d", "Word: Incorrect atribute english")
        XCTAssertEqual(word.native, "Д (д)", "Word: Incorrect atribute native")
        XCTAssertEqual(word.language, .russian, "Word: Incorrect atribute language")
        XCTAssertEqual(word.transliteration, "d", "Word: Incorrect atribute transliteration")
        XCTAssertEqual(word.audioFile, "nil", "Word: Incorrect atribute audioFile")
    }

    func testTopicJSONInitializing() {
        let jsonData: [String: Any] = [

            "name": "AlphabetTest",
            "icon": "settings",
            "words": [
                [
                    "english": "ah",
                    "native": "A",
                    "language": "russian",
                    "transliteration": "ah",
                    "audioFile": "nil"
                ],
                [
                    "english": "b",
                    "native": "Б (б)",
                    "language": "russian",
                    "transliteration": "b",
                    "audioFile": "nil"
                ],
                [
                    "english": "b",
                    "native": "Б (б)",
                    "language": "russian",
                    "transliteration": "b",
                    "audioFile": "nil"
                ],
                [
                    "english": "b",
                    "native": "Б (б)",
                    "language": "russian",
                    "transliteration": "b",
                    "audioFile": "nil"
                ]
            ]
        ]

        let json = JSON(jsonData)

        guard let topic = Topic(json: json) else {
            XCTFail("Failed to parse Topic")
            return
        }

        XCTAssertEqual(topic.name, "AlphabetTest", "Topic: Incorrect atribute name")
        XCTAssertEqual(topic.icon, "settings", "Topic: Incorrect atribute icon")
        XCTAssertEqual(topic.wordsToLearn.count, 4, "Topic: Incorrect atribute words.count")
    }

    func testTopicCanShow() {
        let topic = store.topics[0]

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
        let topic = store.topics[1]

        topic.incrementProgress()

        let randomWord = topic.getRandomWord()
        let randomWords = topic.getRandomWords(word: randomWord, amount: 3)
        XCTAssertEqual(randomWords.count, 3)
    }
}
