import UIKit

class CircleView: UIView {

    var circle: CAShapeLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
        initCircle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initCircle() {
        // MARK: - Circle Setup
        let radius: CGFloat = 100.0
        circle = CAShapeLayer()
        circle.frame = frame
        let circleCenter = center

        let twoPi = 2.0 * Double.pi
        let startAngle = 0
        let endAngle = twoPi

        // Draw the circle
        circle.path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: CGFloat(startAngle),
                                   endAngle: CGFloat(endAngle), clockwise: false).cgPath

        // Configure the circle
        circle.fillColor = UIColor.white.cgColor
        circle.strokeColor = UIColor.red.cgColor
        circle.lineWidth = 5

        // MARK: - Animations

        let keytimes: [NSNumber] = [0, 0.2, 0.7, 1]

        // Create scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [0.0, 1.0, 1.0, 10]
        scaleAnimation.keyTimes = keytimes
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        // Create opacity animation
        let secondScale = CAKeyframeAnimation(keyPath: "opacity")
        secondScale.values = [1.0, 1.0, 1.0, 0.0]
        secondScale.keyTimes = keytimes
        secondScale.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

        // Create group animation to store the scale and opcacity animation
        let group = CAAnimationGroup()
        group.duration = 1
        group.repeatCount = 9
        group.animations = [scaleAnimation, secondScale]

        circle.add(group, forKey: "group")

        self.layer.addSublayer(circle)
    }
}
