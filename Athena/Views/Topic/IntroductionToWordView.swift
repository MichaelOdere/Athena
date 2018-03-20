import UIKit

class IntroductionToWordView: UIView {
    var gl: CAGradientLayer!
    var word: Word
    var bigNewWordView: NewWordView!
    var littleNewWordView: NewWordView!
    var addLabel: UILabel!

    init(frame: CGRect, word: Word) {
        self.word = word
        super.init(frame: frame)

        initGradientColor()
        initAddLabel()
        initBigNewWordView()
    }

    func initGradientColor() {
        gl = CAGradientLayer()
        gl.frame = self.frame
        gl.colors = [AthenaPalette.lightPink.cgColor, AthenaPalette.rasberryPink.cgColor]
        gl.locations = [0.0, 1.0]
        self.layer.addSublayer(gl)
    }

    func initAddLabel() {
        addLabel = UILabel()
        addLabel.backgroundColor = UIColor.clear
        addLabel.text = "Drag to me to add word!"
        addLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        addLabel.textAlignment = .center
        addLabel.textColor = UIColor.white
        addSubview(addLabel)

        addLabel.translatesAutoresizingMaskIntoConstraints = false

        let bottom = NSLayoutConstraint(item: addLabel,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: 0)
        bottom.isActive = true

        let height = NSLayoutConstraint(item: addLabel,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .height,
                                        multiplier: 1/5,
                                        constant: 0)
        height.isActive = true

        let width = NSLayoutConstraint(item: addLabel,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: self,
                                       attribute: .width,
                                       multiplier: 1/2,
                                       constant: 0)
        width.isActive = true

        let centerX = NSLayoutConstraint(item: addLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        centerX.isActive = true
    }
    func initBigNewWordView() {
        bigNewWordView = NewWordView()
        bigNewWordView.nativeLabel.text = word.native
        bigNewWordView.englishLabel.text = word.english
        bigNewWordView.backgroundColor = UIColor.clear
        addSubview(bigNewWordView)

        bigNewWordView.translatesAutoresizingMaskIntoConstraints = false

        let height = NSLayoutConstraint(item: bigNewWordView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .height,
                                        multiplier: 2/5,
                                        constant: 0)
        height.isActive = true

        let width = NSLayoutConstraint(item: bigNewWordView,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: self,
                                       attribute: .width,
                                       multiplier: 1/2,
                                       constant: 0)
        width.isActive = true

        let centerX = NSLayoutConstraint(item: bigNewWordView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        centerX.isActive = true

        let centerY = NSLayoutConstraint(item: bigNewWordView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: -50)
        centerY.isActive = true
    }

    func initLittleNewWordView() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
