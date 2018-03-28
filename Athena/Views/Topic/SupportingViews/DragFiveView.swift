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
    var originTopLeft: CGPoint!
    var originBototmRight: CGPoint!

    var isValidDrag = false

    let fontSize: CGFloat = 40

    override init(frame: CGRect) {
        super.init(frame: frame)

        size = CGSize(width: frame.width / 3, height: frame.height / 8)
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
        let scale: CGFloat = 1.2
        let centerX = frame.width / 2 - size.width * scale / 2
        let centerY = frame.height / 2 - size.height * scale / 2
        let initFrame = CGRect(x: centerX, y: centerY, width: size.width * scale, height: size.height * scale)
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
                        print(self.delegate)
                        print("complete")
                    })
                }
            }
            dragWord.center = location
            dragWord.removeFromSuperview()
            dragWord = nil
            initDragWord()
        }
    }
}
