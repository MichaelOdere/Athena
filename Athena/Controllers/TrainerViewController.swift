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
        initGradientColor()
    }

    func initGradientColor() {
        let gl = CAGradientLayer()
        gl.frame = self.view.frame
        gl.colors = [AthenaPalette.parisGreen.cgColor, AthenaPalette.turquoise.cgColor]
        gl.locations = [0.0, 1.0]
        view.layer.insertSublayer(gl, at: 0)
    }
}
