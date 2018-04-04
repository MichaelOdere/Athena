import UIKit

class CircleView: UIView {

    var circle: CAShapeLayer!
    let group = CAAnimationGroup()
    let duration = Constants.duration

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        initCircle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Circle Setup
    func initCircle() {
        circle = CAShapeLayer()
        circle.frame = frame
        let radius: CGFloat = frame.width / 2.0
        let circleCenter = center

        let twoPi = 2.0 * Double.pi
        let startAngle = 0
        let endAngle = twoPi

        // Draw the circle
        circle.path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: CGFloat(startAngle),
                                   endAngle: CGFloat(endAngle), clockwise: false).cgPath

        // Configure the circle
        circle.fillColor = UIColor.white.cgColor
        circle.strokeColor = UIColor.white.cgColor
        circle.lineWidth = 5

        self.layer.addSublayer(circle)
    }

    // MARK: - Animations
    func initAnimations(vc: LearnTopicViewController) {
        group.delegate = vc
        initAnimations()
    }

    func initAnimations() {
        let keytimes: [NSNumber] = [0, 0.1, 0.9, 1]

        // Create scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [0.0, 1.0, 1.0, 5]
        scaleAnimation.keyTimes = keytimes
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        // Create opacity animation
        let secondScale = CAKeyframeAnimation(keyPath: "opacity")
        secondScale.values = [1.0, 1.0, 1.0, 0.0]
        secondScale.keyTimes = keytimes
        secondScale.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

        // Create group animation to store the scale and opcacity animation
        group.duration = duration
        group.repeatCount = 1
        group.animations = [scaleAnimation, secondScale]
        circle.add(group, forKey: "group")
    }
}
