import UIKit

class SuccessView: UIView {

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
        // Set the center of the circle to be the center of the view
        let circleCenter = center//CGPoint(x: center.x - radius, y: center.y - radius)

        let fractionOfCircle = 3.0 / 4.0

        let twoPi = 2.0 * Double.pi
        let startAngle = Double(fractionOfCircle) / Double(twoPi) - Double.pi
        let endAngle = 0.0 - Double.pi
        let clockwise: Bool = true

        // `clockwise` tells the circle whether to animate in a clockwise or anti clockwise direction
        circle.path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).cgPath

        // Configure the circle
        circle.fillColor = UIColor.white.cgColor
        circle.strokeColor = UIColor.red.cgColor
        circle.lineWidth = 5

        // When it gets to the end of its animation, leave it at 0% stroke filled
        circle.strokeEnd = 0.0

        // Add the circle to the parent layer
        self.layer.addSublayer(circle)

        // Configure the animation
        var drawAnimation = CABasicAnimation(keyPath: "transform.scale")
        drawAnimation.repeatCount = 10.0

        drawAnimation.fromValue = NSNumber(value: 0.0)
        drawAnimation.toValue = NSNumber(value: 1.0)
//        let tempSize = circle.frame.size
//        drawAnimation.fromValue = NSValue(cgSize: CGSize.zero)
//        drawAnimation.toValue = NSValue(cgSize: tempSize)
//        drawAnimation.fromValue = 0
//        drawAnimation.toValue = 100

        drawAnimation.duration = 0.4

        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

        // Add the animation to the circle
        circle.add(drawAnimation, forKey: "translation")
//        drawAnimation = CABasicAnimation(keyPath: "transform.scale.y")
//        circle.add(drawAnimation, forKey: "transform.scale.y")
    }
}
