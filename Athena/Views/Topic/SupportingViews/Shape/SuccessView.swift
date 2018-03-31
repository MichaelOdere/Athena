import UIKit

class SuccessView: UIView {
    var circleView: CircleView!
    var checkMarkRight: CAShapeLayer!
    var checkMarkLeft: CAShapeLayer!

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
        circleView = CircleView(frame: frame)
        self.addSubview(circleView)
    }
    // swiftlint:disable shorthand_operator
    func initVariables(size: CGSize) {
        height = frame.height * 0.01
        width = frame.width * 0.05
        top = frame.height * 0.45
        bottom = frame.height - top
        left = frame.width * 0.4
        right = frame.width - left
        left = left + 0.5 * width
        right = right + 0.5 * width
    }

    func initSlantLeft() {
//        let path = UIBezierPath()
        let slope = ((bottom) - (top + height) ) / ((left + width) - (right))
        let intercept = -1 * (slope * right - (top + height))
//        let intercept2 = 0.9 * intercept1
//        path.move(to: CGPoint(x: left + 1 * width, y: ((left + 1 * width) * slope + intercept1)))
//        path.addLine(to: CGPoint(x: left + 1.8 * width, y: ((left + 1.8 * width) * slope + intercept1)))
//        path.addLine(to: CGPoint(x: left - 0.3 * width, y: ((left - 0.3 * width) * slope + intercept2)))
//        path.addLine(to: CGPoint(x: left - 1.1 * width, y: ((left - 1.1 * width) * slope + intercept2)))

    //        path.addLine(to: CGPoint(x: left - 0.1 * left, y: bottom - 0.12 * bottom))
//        path.addLine(to: CGPoint(x: left - 1.5 * width, y: bottom - 0.06 * bottom))
        let path = UIBezierPath()
        path.move(to: CGPoint(x: left + 1 * width, y: ((left + 1 * width) * slope + intercept)))
        path.addLine(to: CGPoint(x: left + 0.4 * width, y: ((left + 0.4 * width) * slope + intercept)))
//        path.addLine(to: CGPoint(x: left + width, y: bottom))
        path.addLine(to: CGPoint(x: 0.9 * left, y: ((0.9 * left) * slope + intercept - 65)))
        path.addLine(to: CGPoint(x: left, y: ((left) * slope + intercept - 65)))
//        path.addLine(to: CGPoint(x: left, y: bottom - height))
        path.close()

        checkMarkLeft = CAShapeLayer()
        checkMarkLeft.frame = self.bounds
        checkMarkLeft.path = path.cgPath
        checkMarkLeft.fillColor = AthenaPalette.parisGreen.cgColor
//        checkMarkLeft.fillColor = AthenaPalette.turquoise.cgColor
        circleView.circle.addSublayer(checkMarkLeft)
    }

    func initSlantRight() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: right, y: top + height))
        path.addLine(to: CGPoint(x: right - width, y: top))
        path.addLine(to: CGPoint(x: left, y: bottom - height))
        path.addLine(to: CGPoint(x: left + width, y: bottom))
        path.close()

        checkMarkRight = CAShapeLayer()
        checkMarkRight.frame = self.bounds
        checkMarkRight.path = path.cgPath
        checkMarkRight.fillColor = AthenaPalette.parisGreen.cgColor
        circleView.circle.addSublayer(checkMarkRight)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
