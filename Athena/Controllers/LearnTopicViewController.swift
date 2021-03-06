import UIKit

enum LearnView: String {
    case reset
    case introductionToWord
    case dragFiveToCorrectView
    case dragThreeToCorrectView
    case swipeWordView
}

protocol DoneHandlerProtocol: class {
    func previousView(previous: LearnView, result: ResultOfLearn)
}

class LearnTopicViewController: UIViewController {

    var introductionToWordView: IntroductionToWordView!
    var dragFiveToCorrectView: DragFiveToCorrectView!
    var dragThreeToCorrectView: DragThreeToCorrectView!
    var swipeWordView: SwipeWordView!

    var topic: TopicWrapper!
    var dayStore: DayStore!

    var nextView: LearnView!
    var lastResult: ResultOfLearn!

    var successView: SuccessView!
    var failView: FailView!

    override func viewDidLoad() {
        let resultRect = CGRect(x: 0, y: view.frame.height / 2 - view.frame.width / 2,
                                width: view.frame.width, height: view.frame.width)
        successView = SuccessView(frame: resultRect)
        failView = FailView(frame: resultRect)

        introductionToWordView = IntroductionToWordView(frame: view.frame)
        introductionToWordView.delegate = self

        dragFiveToCorrectView = DragFiveToCorrectView(frame: view.frame)
        dragFiveToCorrectView.progressView.topicTitle = topic.name
        dragFiveToCorrectView.delegate = self

        dragThreeToCorrectView = DragThreeToCorrectView(frame: view.frame)
        dragThreeToCorrectView.progressView.topicTitle = topic.name
        dragThreeToCorrectView.delegate = self

        swipeWordView = SwipeWordView(frame: view.frame)
        swipeWordView.progressView.topicTitle = topic.name
        swipeWordView.delegate = self

        nextView = LearnView(rawValue: topic.topic.lastTopicView!)
        showNextView(centerWord: nil)
    }
}

// MARK: - DoneHandlerProtocol
extension LearnTopicViewController: DoneHandlerProtocol {
    // Determine what the next view should be and set the value of the nextView variable
    func previousView(previous: LearnView, result: ResultOfLearn) {
        lastResult = result
        topic.updateAfterResult(result: result)
        dayStore.getCurrentDay().updateAfterResult(result: result)
        topic.saveContext()
        switch previous {
        case .reset:
            nextView = previousViewInitial()
            showNextView(centerWord: result.getWord())
        case .introductionToWord:
            nextView = previousViewIntroduction(result: result)
            showNextView(centerWord: result.getWord())
        case .dragFiveToCorrectView:
            nextView = previousViewDrag(result: result)
            showResult(result: result)
        case .dragThreeToCorrectView:
            nextView = previousViewDrag(result: result)
            showResult(result: result)
        case .swipeWordView:
            nextView = previousSwipeView(result: result)
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
            return .swipeWordView
        case .incorrect:
            return .dragThreeToCorrectView
        default:
            return .reset
        }
    }

    func previousSwipeView(result: ResultOfLearn) -> LearnView {
        switch result {
        case .correct:
            return .reset
        case .incorrect:
            return .swipeWordView
        default:
            return .reset
        }
    }
}

// MARK: - Show Next View Logic
extension LearnTopicViewController {
    func showNextView(centerWord: Word?) {
        topic.topic.lastTopicView = nextView.rawValue
        switch nextView {
        case .reset:
            previousView(previous: .reset, result: .none)
        case .introductionToWord:
            showIntroductionToWordView()
        case .dragFiveToCorrectView:
            showDragFiveToCorrectView(centerWord: centerWord)
        case .dragThreeToCorrectView:
            showDragThreeToCorrectView(centerWord: centerWord)
        case .swipeWordView:
            showSwipeWordView(centerWord: centerWord)
        default:
            previousView(previous: .reset, result: .none)
        }
    }

    func showIntroductionToWordView() {
        removeAllSubviews()
        view.addSubview(introductionToWordView)
        if let word = topic.getNextWord() {
            introductionToWordView.sendWord(word: word)
        } else {
            previousView(previous: .introductionToWord, result: .none)
        }
    }

    func showDragFiveToCorrectView(centerWord: Word?) {
        dragFiveToCorrectView.progressView.percentageComplete = topic.getPercentageComplete()
        removeAllSubviews()
        view.addSubview(dragFiveToCorrectView)
        dragFiveToCorrectView.dragView.setup()

        if centerWord == nil {
            guard let randomWord = topic.getRandomWord(learned: true) else {
                nextView = .reset
                showNextView(centerWord: nil)
                return
            }

            let words =  topic.getRandomWords(word: randomWord, amount: 4)
            dragFiveToCorrectView.dragView.setText(word: randomWord, nativeWords: topic.getEnglishString(words: words))
        } else {
            let words =  topic.getRandomWords(word: centerWord!, amount: 4)
            dragFiveToCorrectView.dragView.setText(word: centerWord!, nativeWords: topic.getEnglishString(words: words))
        }
    }

    func showDragThreeToCorrectView(centerWord: Word?) {
        dragThreeToCorrectView.progressView.percentageComplete = topic.getPercentageComplete()
        removeAllSubviews()
        view.addSubview(dragThreeToCorrectView)
        dragThreeToCorrectView.dragView.setup()

        if centerWord == nil {
            guard let randomWord = topic.getRandomWord(learned: true) else {
                nextView = .reset
                showNextView(centerWord: nil)
                return
            }
            let words =  topic.getRandomWords(word: randomWord, amount: 2)
            dragThreeToCorrectView.dragView.setText(word: randomWord,
                                                    nativeWords: topic.getEnglishString(words: words))
        } else {
            let words =  topic.getRandomWords(word: centerWord!, amount: 2)
            dragThreeToCorrectView.dragView.setText(word: centerWord!,
                                                    nativeWords: topic.getEnglishString(words: words))
        }
    }

    func showSwipeWordView(centerWord: Word?) {
        swipeWordView.animateView()
        swipeWordView.progressView.percentageComplete = topic.getPercentageComplete()
        var randomWord: Word!

        if centerWord == nil {
            guard let tempRandomWord = topic.getRandomWord(learned: true) else {
                nextView = .reset
                showNextView(centerWord: nil)
                return
            }
            randomWord = tempRandomWord
        } else {
            randomWord = centerWord
        }

        let words = topic.getRandomWords(word: randomWord, amount: 2)

        // 1 = no match 2 = match
        let match = (Int(arc4random_uniform(UInt32(2))) + 1) == 2
        if match {
            swipeWordView.setText(word: randomWord, native: randomWord.native!,
                                  english: randomWord.english!, match: match)
        } else {
            swipeWordView.setText(word: randomWord, native: randomWord.native!,
                                  english: words[1].english!, match: match)
        }

        view.addSubview(swipeWordView)
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
        showNextView(centerWord: lastResult.getWord())
    }
}
