import UIKit

enum ResultOfLearn {
    case learned
    case notLearned
    case answerCorrent
    case answerWrong
}

protocol DoneHandlerProtocol: class {
    func nextView(tag: Int)
    func outcome(result: ResultOfLearn)
}

class LearnTopicViewController: UIViewController {

    var introductionToWordView: IntroductionToWordView!
    var dragToCorrectView: DragToCorrectView!
    var topic: Topic!

    override func viewDidLoad() {
        introductionToWordView = IntroductionToWordView(frame: self.view.frame)
        introductionToWordView.delegate = self
        dragToCorrectView = DragToCorrectView(frame: self.view.frame)
        dragToCorrectView.delegate = self

        nextView(tag: 0)
    }
}

extension LearnTopicViewController: DoneHandlerProtocol {
    func nextView(tag: Int) {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        if tag == 0 && topic.wordsLearned.count > 0 {
            view.addSubview(dragToCorrectView)
            dragToCorrectView.dragView.setup()
            let randomIndex = Int(arc4random_uniform(UInt32(topic.wordsLearned.count)))
            let word = topic.wordsLearned[randomIndex]
            dragToCorrectView.dragView.setText(word: word, nativeWords: getRandomWords(word: word))
        } else if topic.wordsToLearn.count > 0 {
            view.addSubview(introductionToWordView)
            introductionToWordView.sendWord(word: topic.wordsToLearn[0])
            incrementTopicsProgress()
        } else {
            nextView(tag: 0)
//            navigationController?.popViewController(animated: false)
        }
    }

    func outcome(result: ResultOfLearn) {
        print(result)
    }

    func getRandomWords(word: Word) -> [String] {
        var words: [String] = [word.english]
        var indexes: [Int] = []

        if let index = topic.wordsLearned.index(where: {$0.english == word.english}) {
            indexes.append(index)
        }

        // Get random words while we don't have 4 and wordsLearned still has unused words
        while words.count < 4 && indexes.count < topic.wordsLearned.count {
            let randomIndex = Int(arc4random_uniform(UInt32(topic.wordsLearned.count)))
            let english = topic.wordsLearned[randomIndex].english

            if !indexes.contains(randomIndex) && !words.contains(english) {
                words.append(english)
                indexes.append(randomIndex)
            }
        }

        indexes = []

        if let index = topic.wordsToLearn.index(where: {$0.english == word.english}) {
            indexes.append(index)
        }

        // Get random words while we don't have 4 and wordsToLearn still  has unused words
        while words.count < 4 && indexes.count < topic.wordsToLearn.count {
            let randomIndex = Int(arc4random_uniform(UInt32(topic.wordsToLearn.count)))
            let english = topic.wordsToLearn[randomIndex].english

            if !indexes.contains(randomIndex) && !words.contains(english) {
                words.append(english)
                indexes.append(randomIndex)
            }
        }

        return words
    }

    func incrementTopicsProgress() {
        let defaults = UserDefaults.standard
        let current = defaults.integer(forKey: topic.name)
        defaults.set(current + 1, forKey: topic.name)

        if topic.wordsToLearn.count > 0 {
            topic.wordsLearned.append(topic.wordsToLearn[0])
            topic.wordsToLearn.remove(at: 0)
        }
    }
}
