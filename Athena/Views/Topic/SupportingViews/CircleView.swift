import UIKit

class CircleView: UIView {

    var circle: CAShapeLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCircle()
        self.layer.addSublayer(circle)
        backgroundColor = UIColor.red
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initCircle() {
        let radius: CGFloat = 100.0
        circle = CAShapeLayer()
        circle.frame = frame
        let circleCenter = center

        let fractionOfCircle = 3.0 / 4.0

        let twoPi = 2.0 * Double.pi
        let startAngle = Double(fractionOfCircle) / Double(twoPi) - Double.pi
        let endAngle = 0.0 - Double.pi
        let clockwise: Bool = true

        circle.path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).cgPath

        // Configure the circle
        circle.fillColor = UIColor.white.cgColor
        circle.strokeColor = UIColor.red.cgColor
        circle.lineWidth = 5

        circle.strokeEnd = 0.0

        self.layer.addSublayer(circle)

        let group = CAAnimationGroup()
        group.duration = 1
        group.repeatCount = 9
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [0.0, 1.0, 1.0, 10]
        scaleAnimation.keyTimes = [0, 0.2, 0.7, 1]
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let secondScale = CAKeyframeAnimation(keyPath: "opacity")
        secondScale.values = [1.0, 1.0, 1.0, 0.0]
        secondScale.keyTimes = [0, 0.2, 0.7, 1]
        secondScale.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

        group.animations = [scaleAnimation, secondScale]
        circle.add(group, forKey: "group")
    }
}
