import UIKit

protocol DoneHandlerProtocol: class {
    func nextView(tag: Int)
}

class LearnTopicViewController: UIViewController {

    var introductionToWordView: IntroductionToWordView!
    var dragToCorrectView: DragToCorrectView!
    var topic: Topic!

    override func viewDidLoad() {
        introductionToWordView = IntroductionToWordView(frame: self.view.frame, word: topic.wordsToLearn[0])
        introductionToWordView.delegate = self
        dragToCorrectView = DragToCorrectView(frame: self.view.frame)
        dragToCorrectView.delegate = self
        view.addSubview(introductionToWordView)
    }
}

extension LearnTopicViewController: DoneHandlerProtocol {
    func nextView(tag: Int) {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        if tag == 0 {
            view.addSubview(dragToCorrectView)
            dragToCorrectView.dragView.setup()
        } else {
            view.addSubview(introductionToWordView)
        }
    }
}
