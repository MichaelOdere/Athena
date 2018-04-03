import UIKit

enum LearnView {
    case reset
    case introductionToWord
    case dragFiveToCorrectView
    case dragThreeToCorrectView
}

protocol DoneHandlerProtocol: class {
    func previousView(previous: LearnView, result: ResultOfLearn)
}

class LearnTopicViewController: UIViewController {

    var introductionToWordView: IntroductionToWordView!
    var dragFiveToCorrectView: DragFiveToCorrectView!
    var dragThreeToCorrectView: DragThreeToCorrectView!

    var nextView: LearnView!

    var successView: SuccessView!
    var failView: FailView!

    var lastResult: ResultOfLearn!

    var topic: Topic!

    override func viewDidLoad() {
        successView = SuccessView(frame: view.frame)
        failView = FailView(frame: view.frame)

        introductionToWordView = IntroductionToWordView(frame: self.view.frame)
        introductionToWordView.delegate = self

        dragFiveToCorrectView = DragFiveToCorrectView(frame: self.view.frame)
        dragFiveToCorrectView.progressView.topicTitle = topic.name
        dragFiveToCorrectView.delegate = self

        dragThreeToCorrectView = DragThreeToCorrectView(frame: self.view.frame)
        dragThreeToCorrectView.progressView.topicTitle = topic.name
        dragThreeToCorrectView.delegate = self

        previousView(previous: .reset, result: .none)
    }
}

// MARK: - DoneHandlerProtocol
extension LearnTopicViewController: DoneHandlerProtocol {
    // Determine what the next view should be and set the value of the nextView variable
    func previousView(previous: LearnView, result: ResultOfLearn) {
        lastResult = result
        switch previous {
        case .reset:
            nextView = previousViewInitial()
            showNextView(dragWord: result.getWord())
        case .introductionToWord:
            nextView = previousViewIntroduction(result: result)
            showNextView(dragWord: result.getWord())
        case .dragFiveToCorrectView:
            nextView = previousViewDrag(result: result)
            showResult(result: result)
        case .dragThreeToCorrectView:
            nextView = previousViewDrag(result: result)
            showResult(result: result)
        }
    }
}

// MARK: - Previous View Logic
// Given a previous view what is the next view we want to show
extension LearnTopicViewController {
    func previousViewInitial() -> LearnView {
        if topic.canShowIntroductionToWordView() {
            return .introductionToWord
        } else {
            return previousViewIntroduction(result: .none)
        }
    }

    func previousViewIntroduction(result: ResultOfLearn) -> LearnView {
        if topic.canShowDragFiveCorrectView() {
            return .dragFiveToCorrectView
        } else if topic.canShowDragThreeCorrectView() {
            return .dragThreeToCorrectView
        } else {
            return .introductionToWord
        }
    }

    // Same logic for dragfive and dragthree
    func previousViewDrag(result: ResultOfLearn) -> LearnView {
        switch result {
        case .correct:
            return .reset
        case .incorrect:
            return .dragThreeToCorrectView
        default:
            return .reset
        }
    }
}

// MARK: - Show Next View Logic
extension LearnTopicViewController {
    func showNextView(dragWord: Word?) {
        switch nextView {
        case .reset:
            previousView(previous: .reset, result: .none)
        case .introductionToWord:
            showIntroductionToWordView()
        case .dragFiveToCorrectView:
            showDragFiveToCorrectView(dragWord: dragWord)
        case .dragThreeToCorrectView:
            showDragThreeToCorrectView(dragWord: dragWord)
        default:
            previousView(previous: .reset, result: .none)
        }
    }

    func showIntroductionToWordView() {
        removeAllSubviews()
        view.addSubview(introductionToWordView)
        introductionToWordView.sendWord(word: topic.wordsToLearn[0])
        topic.incrementProgress()
    }

    func showDragFiveToCorrectView(dragWord: Word?) {
        dragFiveToCorrectView.progressView.percentageComplete = topic.getPercentageComplete()
        removeAllSubviews()
        view.addSubview(dragFiveToCorrectView)
        dragFiveToCorrectView.dragView.setup()

        if dragWord == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(topic.wordsLearned.count)))
            let randomWord = topic.wordsLearned[randomIndex]
            let words =  topic.getRandomWords(word: randomWord, amount: 4)
            dragFiveToCorrectView.dragView.setText(word: randomWord, nativeWords: words)
        } else {
            let words =  topic.getRandomWords(word: dragWord!, amount: 4)
            dragFiveToCorrectView.dragView.setText(word: dragWord!, nativeWords: words)
        }
    }

    func showDragThreeToCorrectView(dragWord: Word?) {
        dragThreeToCorrectView.progressView.percentageComplete = topic.getPercentageComplete()
        removeAllSubviews()
        view.addSubview(dragThreeToCorrectView)
        dragThreeToCorrectView.dragView.setup()

        if dragWord == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(topic.wordsLearned.count)))
            let randomWord = topic.wordsLearned[randomIndex]
            let words =  topic.getRandomWords(word: randomWord, amount: 2)
                dragThreeToCorrectView.dragView.setText(word: randomWord, nativeWords: words)
        } else {
            let words = topic.getRandomWords(word: dragWord!, amount: 2)
            dragThreeToCorrectView.dragView.setText(word: dragWord!, nativeWords: words)
        }
    }

    // Loads the green check mark or red x animation depending on the result
    func showResult(result: ResultOfLearn) {
        switch result {
        case .correct:
            view.addSubview(successView)
            successView.circleView.initAnimations(vc: self)
        case .incorrect:
            view.addSubview(failView)
            failView.circleView.initAnimations(vc: self)
        default:
            view.addSubview(failView)
            failView.circleView.initAnimations(vc: self)
        }
    }

    func removeAllSubviews() {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
}

extension LearnTopicViewController: CAAnimationDelegate {
    // Alerts us that the animation is complete so we can load the next view
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        showNextView(dragWord: lastResult.getWord())
    }
}
