import UIKit

class IntroductionToWordView: UIView {
    var word: Word

    var bigSize: CGSize!
    var bigNewWordView: NewWordView!
    var littleNewWordView: NewWordView!

    var addLabel: UILabel!

    var gl: CAGradientLayer!

    init(frame: CGRect, word: Word) {
        self.word = word
        super.init(frame: frame)

        bigSize = CGSize(width: frame.width * 1/2, height: frame.height *  2/5)

        initGradientColor()
        initAddLabel()
        initBigNewWordView()
        initLittleNewWordView(point: CGPoint.zero)
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

        addLabel.layer.cornerRadius = 20
        addLabel.layer.masksToBounds = true

        addLabel.text = "Drag to me to add!"
        addLabel.textColor = UIColor.white
        addLabel.textAlignment = .center
        addLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 14)

        addLabel.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        addSubview(addLabel)

        addLabel.translatesAutoresizingMaskIntoConstraints = false

        let bottom = NSLayoutConstraint(item: addLabel,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: -20)
        bottom.isActive = true

        let height = NSLayoutConstraint(item: addLabel,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .height,
                                        multiplier: 3/10,
                                        constant: 0)
        height.isActive = true

        let width = NSLayoutConstraint(item: addLabel,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: self,
                                       attribute: .height,
                                       multiplier: 3/10,
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
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: bigSize.height)
        height.isActive = true

        let width = NSLayoutConstraint(item: bigNewWordView,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .width,
                                       multiplier: 1,
                                       constant: bigSize.width)
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

    func initLittleNewWordView(point: CGPoint) {
        let littleFrame = CGRect(x: point.x, y: point.y, width: bigSize.width / 4, height: bigSize.height / 4)
        littleNewWordView = NewWordView(frame: littleFrame)

        let fontSize = littleNewWordView.fontSize
        let fontMultiplier = littleNewWordView.fontMultiplier
        littleNewWordView.nativeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize / 4)
        littleNewWordView.englishLabel.font = UIFont(name: "HelveticaNeue-Bold", size: (fontSize * fontMultiplier) / 4)

        littleNewWordView.nativeLabel.text = word.native
        littleNewWordView.englishLabel.text = word.english

        littleNewWordView.backgroundColor = UIColor.clear
        addSubview(littleNewWordView)

        // Don't want to show this view when we initialize
        littleNewWordView.isHidden = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            bigNewWordView.isHidden = true
            littleNewWordView.isHidden = false
            littleNewWordView.center = location
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            littleNewWordView.center = location
        }

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            bigNewWordView.isHidden = false
            littleNewWordView.isHidden = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
