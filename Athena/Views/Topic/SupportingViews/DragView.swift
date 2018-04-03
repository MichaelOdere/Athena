import UIKit

class DragView: UIView {
    weak var delegate: DoneHandlerProtocol?

    var labels: [UILabel] = []

    var dragWord: UILabel!

    // Word in the center used as the drag word
    var word: Word!

    var size: CGSize!
    var dragOrigin: CGPoint!
    var dragCenter: CGPoint!
    var originTopLeft: CGPoint!
    var originBototmRight: CGPoint!

    var isValidDrag = false

    let fontSize: CGFloat = 40
    let scale: CGFloat = 2.0

    override init(frame: CGRect) {
        super.init(frame: frame)

        size = CGSize(width: frame.width / 3, height: frame.height / 8)
        let centerX = frame.width / 2 - size.width * scale / 2
        let centerY = frame.height / 2 - size.height * scale / 2
        dragOrigin = CGPoint(x: centerX, y: centerY)
        originTopLeft = CGPoint(x: 0, y: 0)
        originBototmRight = CGPoint(x: frame.width - size.width, y: frame.height - size.height)
    }

    func shuffleArray(arr: [String]) -> [String] {
        var tempArr = arr
        var shuffled: [String] = []

        for count in 0..<tempArr.count {
            let randomIndex = Int(arc4random_uniform(UInt32(arr.count - count)))
            shuffled.append(tempArr[randomIndex])
            tempArr.remove(at: randomIndex)
        }

        return shuffled
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Touch
extension DragView {
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
                    var result: ResultOfLearn = .incorrect(word)
                    if label.text == word.english {
                        result = .correct
                    }
                    UIView.animate(withDuration: 0.6,
                                   delay: 0,
                                   options: [],
                                   animations: {
                                    self.alpha = 0
                                    self.delegate?.previousView(previous: .dragFiveToCorrectView, result: result)
                    },
                                   completion: { (_) in
                                    self.alpha = 1
                                    self.dragWord.frame.origin = self.dragOrigin
                    })
                    return
                }
            }

            UIView.animate(withDuration: 0.2, animations: {
                self.dragWord.frame.origin = self.dragOrigin
            })
        }
    }
}

// MARK: - Animations
extension DragView {
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
            label.center = dragCenter
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
}
