import UIKit

enum PreviusView {
    case initialView
    case introductionToWord
    case dragToCorrectView
}

enum ResultOfLearn {
    case learned
    case notLearned
    case correct
    case incorrect
}

protocol DoneHandlerProtocol: class {
    func nextView(previous: PreviusView, result: ResultOfLearn)
}

class LearnTopicViewController: UIViewController {

    var introductionToWordView: IntroductionToWordView!
    var dragToCorrectView: DragToCorrectView!

    var successView: SuccessView!
    var failView: FailView!

    var topic: Topic!

    override func viewDidLoad() {
        successView = SuccessView(frame: view.frame)
        failView = FailView(frame: view.frame)

        introductionToWordView = IntroductionToWordView(frame: self.view.frame)
        introductionToWordView.delegate = self

        dragToCorrectView = DragToCorrectView(frame: self.view.frame)
        dragToCorrectView.progressView.topicTitle = topic.name
        dragToCorrectView.delegate = self

        nextView(previous: .initialView, result: .learned)
    }
}

extension LearnTopicViewController: DoneHandlerProtocol {

    func nextView(previous: PreviusView, result: ResultOfLearn) {
        switch previous {
        case .initialView:
            if !showNewWord() {
                _ = showDragToCorrectView()
            }
        case .introductionToWord:
            if !showDragToCorrectView() {
                _ = showNewWord()
            }
        case .dragToCorrectView:
            showResult(result: result)
        }
    }

    func showNewWord() -> Bool {
        if topic.wordsToLearn.count > 0 {
            removeAllSubviews()
            view.addSubview(introductionToWordView)
            introductionToWordView.sendWord(word: topic.wordsToLearn[0])
            incrementTopicsProgress()
            return true
        }
        return false
    }

    func showDragToCorrectView() -> Bool {
        dragToCorrectView.progressView.percentageComplete = topic.getPercentageComplete()
        if topic.wordsLearned.count > 0 {
            removeAllSubviews()
            view.addSubview(dragToCorrectView)
            dragToCorrectView.dragView.setup()
            let randomIndex = Int(arc4random_uniform(UInt32(topic.wordsLearned.count)))
            let word = topic.wordsLearned[randomIndex]
            dragToCorrectView.dragView.setText(word: word, nativeWords: getRandomWords(word: word))
            return true
        }
        return false
    }

    func showResult(result: ResultOfLearn) {
        if result == .correct {
            view.addSubview(successView)
            successView.circleView.initAnimations(vc: self)
        }

        if result == .incorrect {
            view.addSubview(failView)
            failView.circleView.initAnimations(vc: self)
        }
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

    func removeAllSubviews() {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
}

extension LearnTopicViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        removeAllSubviews()
        nextView(previous: .initialView, result: .correct)
    }
}
