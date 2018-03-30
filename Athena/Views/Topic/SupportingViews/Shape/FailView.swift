import UIKit

class FailView: UIView {
    var circleView: CircleView!
    var slantLeft: CAShapeLayer!
    var slantRight: CAShapeLayer!
    var xShape: CAShapeLayer!

    var width: CGFloat!
    var height: CGFloat!
    var topLeftPoint: CGPoint!
    var bottomRightPoint: CGPoint!

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

    func initVariables(size: CGSize) {
        width = frame.width * 0.2
        height = frame.height * 0.1
        topLeftPoint = CGPoint(x: 0, y: frame.height * 0.4)
        bottomRightPoint = CGPoint(x: frame.width, y: frame.height * 0.6)
    }

    func initSlantLeft() {
        let path = UIBezierPath()
        path.move(to: topLeftPoint)
        path.addLine(to: CGPoint(x: topLeftPoint.x + width, y: topLeftPoint.y - height))
        path.addLine(to: bottomRightPoint)
        path.addLine(to: CGPoint(x: bottomRightPoint.x - width, y: bottomRightPoint.y + height))
        path.close()

        slantLeft = CAShapeLayer()
        slantLeft.frame = self.bounds
        slantLeft.path = path.cgPath
        slantLeft.fillColor = AthenaPalette.maximumRed.cgColor
        self.layer.addSublayer(slantLeft)
    }

    func initSlantRight() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bottomRightPoint.x, y: topLeftPoint.y))
        path.addLine(to: CGPoint(x: bottomRightPoint.x - width, y: topLeftPoint.y - height))
        path.addLine(to: CGPoint(x: topLeftPoint.x, y: bottomRightPoint.y))
        path.addLine(to: CGPoint(x: topLeftPoint.x + width, y: bottomRightPoint.y + height))
        path.close()

        slantRight = CAShapeLayer()
        slantRight.frame = self.bounds
        slantRight.path = path.cgPath
        slantRight.fillColor = AthenaPalette.maximumRed.cgColor
        self.layer.addSublayer(slantRight)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
