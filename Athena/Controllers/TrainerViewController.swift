import UIKit

class TrainerViewController: UIViewController {
    var trainerView: UIView! {
        didSet {
            for subView in view.subviews {
                subView.removeFromSuperview()
            }
            view.addSubview(trainerView)
        }
    }

    override func viewDidLoad() {
        view.backgroundColor = UIColor.red
    }
}
