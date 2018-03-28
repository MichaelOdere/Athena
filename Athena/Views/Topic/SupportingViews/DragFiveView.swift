import UIKit

class DragFiveView: UIView {

    weak var delegate: DoneHandlerProtocol?

    var topLeft: UILabel!
    var topRight: UILabel!
    var dragWord: UILabel!
    var bottomLeft: UILabel!
    var bottomRight: UILabel!

    var labels: [UILabel] = []

    var size: CGSize!
    var dragCenter: CGPoint!
    var originTopLeft: CGPoint!
    var originBototmRight: CGPoint!

    var isValidDrag = false

    let fontSize: CGFloat = 40
    let scale: CGFloat = 1.2

    override init(frame: CGRect) {
        super.init(frame: frame)

        size = CGSize(width: frame.width / 3, height: frame.height / 8)
        let centerX = frame.width / 2 - size.width * scale / 2
        let centerY = frame.height / 2 - size.height * scale / 2
        dragCenter = CGPoint(x: centerX, y: centerY)
        originTopLeft = CGPoint(x: 0, y: 0)
        originBototmRight = CGPoint(x: frame.width - size.width, y: frame.height - size.height)

        initTopLeft()
        initTopRight()
        initDragWord()
        initBottomLeft()
        initBottomRight()

        labels = [topLeft, topRight, bottomLeft, bottomRight]
        setup()
    }

    func setup() {
        setText()
        hideLabels()
        animateLabels()
    }

    func hideLabels() {
        for label in labels {
            label.alpha = 0
        }
    }

    func animateLabels() {
        let duration = 0.2
        var delay = 0.0

        for label in labels {
            let tempCenter = label.center
            label.center = dragWord.center
            UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
                label.center = tempCenter
                label.alpha = 1
            }, completion: nil)
            delay += duration
        }
    }

    func addShakeAnimation() {
        for label in labels {
            let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.duration = 0.1
            animation.repeatCount = .infinity
            animation.autoreverses = true
//            animation.fromValue = NSValue(cgPoint: CGPoint(x: label.center.x - 10, y: label.center.y))
//            animation.toValue = NSValue(cgPoint: CGPoint(x: label.center.x + 10, y: label.center.y))
            animation.fromValue = NSNumber(value: Double.pi / 80)
            animation.toValue = NSNumber(value: -Double.pi / 80)

            label.layer.add(animation, forKey: "transform.rotation.z")
        }
    }

    func removeAllAnimations() {
        for label in labels {
            label.layer.removeAllAnimations()
        }
    }

    func initTopLeft() {
        let initFrame = CGRect(x: originTopLeft.x, y: originTopLeft.y, width: size.width, height: size.height)
        topLeft = UILabel(frame: initFrame)
        topLeft.backgroundColor = UIColor.clear
        topLeft.textColor = UIColor.white
        topLeft.textAlignment = .center
        topLeft.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        addSubview(topLeft)
    }

    func initTopRight() {
        let initFrame = CGRect(x: originBototmRight.x, y: originTopLeft.y, width: size.width, height: size.height)
        topRight = UILabel(frame: initFrame)
        topRight.backgroundColor = UIColor.clear
        topRight.textColor = UIColor.white
        topRight.textAlignment = .center
        topRight.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        addSubview(topRight)
    }

    func initDragWord() {
        let initFrame = CGRect(x: dragCenter.x, y: dragCenter.y, width: size.width * scale, height: size.height * scale)
        dragWord = UILabel(frame: initFrame)
        dragWord.backgroundColor = UIColor.clear
        dragWord.textColor = UIColor.white
        dragWord.textAlignment = .center
        dragWord.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize + 20)
        dragWord.text = "Test"
        addSubview(dragWord)
    }

    func initBottomLeft() {
        let initFrame = CGRect(x: originTopLeft.x, y: originBototmRight.y, width: size.width, height: size.height)
        bottomLeft = UILabel(frame: initFrame)
        bottomLeft.backgroundColor = UIColor.clear
        bottomLeft.textColor = UIColor.white
        bottomLeft.textAlignment = .center
        bottomLeft.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        addSubview(bottomLeft)
    }

    func initBottomRight() {
        let initFrame = CGRect(x: originBototmRight.x, y: originBototmRight.y, width: size.width, height: size.height)
        bottomRight = UILabel(frame: initFrame)
        bottomRight.backgroundColor = UIColor.clear
        bottomRight.textColor = UIColor.white
        bottomRight.textAlignment = .center
        bottomRight.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        addSubview(bottomRight)
    }

    func setText() {
        topLeft.text = "Test"
        topRight.text = "Test"
        dragWord.text = "Test"
        bottomLeft.text = "Test"
        bottomRight.text = "Test"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DragFiveView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            if dragWord.frame.contains(location) {
                isValidDrag = true
                dragWord.center = location
                addShakeAnimation()
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isValidDrag {
            return
        }

        if let location = touches.first?.location(in: self) {
            dragWord.center = location
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isValidDrag {
            return
        }
        isValidDrag = false

        removeAllAnimations()

        if let location = touches.first?.location(in: self) {
            for label in labels {
                if label.frame.contains(location) {
                    UIView.animate(withDuration: 1,
                                   delay: 0,
                                   options: [],
                    animations: {
                        self.alpha = 0
                    },
                    completion: { (_) in
                        self.alpha = 1
                        self.delegate?.nextView(tag: 1)
                        self.dragWord.frame.origin = self.dragCenter
                    })
                    return
                }
            }

            UIView.animate(withDuration: 0.2, animations: {
                self.dragWord.frame.origin = self.dragCenter
            })
        }
    }
}
