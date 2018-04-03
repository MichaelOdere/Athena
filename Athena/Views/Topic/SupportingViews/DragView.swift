import UIKit

class DragView: UIView {
    weak var delegate: DoneHandlerProtocol?

    var isValidDrag = false

    var labels: [UILabel] = []
    var dragWord: UILabel!
    var currentDrag: UILabel!
    var currentOrigin: CGPoint!

    // Word in the center used as the drag word
    var word: Word!

    var size: CGSize!
    var dragOrigin: CGPoint!
    var dragCenter: CGPoint!
    var originTopLeft: CGPoint!
    var originBototmRight: CGPoint!

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
                setupCurrentDrag(label: dragWord, location: location)
            }

            for label in labels {
                if label.frame.contains(location) {
                    setupCurrentDrag(label: label, location: location)
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isValidDrag {
            return
        }

        if let location = touches.first?.location(in: self) {
            currentDrag.center = location
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isValidDrag {
            return
        }
        isValidDrag = false

        removeAllAnimations()

        if let location = touches.first?.location(in: self) {
            if isDragWord() {
                for label in labels {
                    if label.frame.contains(location) {
                        collisionDetected(collisionLabel: label)
                        return
                    }
                }
            } else {
                if dragWord.frame.contains(location) {
                    collisionDetected(collisionLabel: dragWord)
                    return
                }
            }

            UIView.animate(withDuration: 0.2, animations: {
                self.currentDrag.frame.origin = self.currentOrigin
            })

        }
    }

    func setupCurrentDrag(label: UILabel, location: CGPoint) {
        isValidDrag = true
        currentDrag = label
        currentOrigin = label.frame.origin
        currentDrag.center = location
        addShakeAnimation()
    }

    func collisionDetected(collisionLabel: UILabel) {
        let boolResult = getResultOfCollision(collisionLabel: collisionLabel)
        let result: ResultOfLearn = boolResult ? .correct : .incorrect(word)

        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       options: [],
                       animations: {
                        self.alpha = 0
                        self.delegate?.previousView(previous: .dragFiveToCorrectView, result: result)
        },
                       completion: { (_) in
                        self.alpha = 1
                        self.currentDrag.frame.origin = self.currentOrigin
        })
        return
    }

    func getResultOfCollision(collisionLabel: UILabel) -> Bool {
        if isDragWord() {
            return collisionLabel.text == word.english || collisionLabel.text == word.native
        } else {
            return currentDrag.text == word.english || currentDrag.text == word.native
        }
    }

    // If the current label is the same as the drag center label
    func isDragWord() -> Bool {
        return currentDrag == dragWord
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
