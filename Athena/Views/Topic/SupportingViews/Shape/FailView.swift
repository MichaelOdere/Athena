import UIKit

class FailView: UIView {
    var circleView: CircleView!
    var slantLeft: CAShapeLayer!
    var slantRight: CAShapeLayer!
    var xShape: CAShapeLayer!

    var height: CGFloat!
    var width: CGFloat!
    var top: CGFloat!
    var bottom: CGFloat!
    var left: CGFloat!
    var right: CGFloat!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initCircle()
        initVariables(size: frame.size)
        initSlantLeft()
        initSlantRight()
    }

    func initCircle() {
        circleView = CircleView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.addSubview(circleView)
    }

    func initVariables(size: CGSize) {
        height = frame.height * 0.01
        width = frame.width * 0.05
        top = frame.height * 0.3
        bottom = frame.height - top
        left = frame.width * 0.3
        right = frame.width - left
    }

    func initSlantLeft() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: left, y: top + height))
        path.addLine(to: CGPoint(x: left + width, y: top))
        path.addLine(to: CGPoint(x: right, y: bottom - height))
        path.addLine(to: CGPoint(x: right - width, y: bottom))
        path.close()

        slantLeft = CAShapeLayer()
        slantLeft.frame = self.bounds
        slantLeft.path = path.cgPath
        slantLeft.fillColor = AthenaPalette.maximumRed.cgColor
        circleView.circle.addSublayer(slantLeft)
    }

    func initSlantRight() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: right, y: top + height))
        path.addLine(to: CGPoint(x: right - width, y: top))
        path.addLine(to: CGPoint(x: left, y: bottom - height))
        path.addLine(to: CGPoint(x: left + width, y: bottom))
        path.close()

        slantRight = CAShapeLayer()
        slantRight.frame = self.bounds
        slantRight.path = path.cgPath
        slantRight.fillColor = AthenaPalette.maximumRed.cgColor
        circleView.circle.addSublayer(slantRight)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
