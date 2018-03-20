import UIKit

class LearTopicViewController: UIViewController {

    var introductionToWordView: IntroductionToWordView!
    var topic: Topic!

    override func viewDidLoad() {
        introductionToWordView = IntroductionToWordView(frame: self.view.frame, word: topic.wordsToLearn[0])
        view.addSubview(introductionToWordView)
    }
}
