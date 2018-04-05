import UIKit

class SuccessView: UIView {
    var circleView: CircleView!
    var checkMark: CAShapeLayer!

    var height: CGFloat!
    var width: CGFloat!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initCircle()
        initVariables(size: frame.size)
        initCheckMark()
    }

    func initCircle() {
        circleView = CircleView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.addSubview(circleView)
    }

    func initVariables(size: CGSize) {
        height = frame.height * 0.01
        width = frame.width * 0.05
    }

    func initCheckMark() {
        let origin = CGPoint(x: frame.width / 2 - width, y: frame.height / 2 + 2 * 5 * height)
        let bottomLeft = CGPoint(x: origin.x - 2 * width, y: origin.y - 10 * height)
        let topRight = CGPoint(x: origin.x + 3 * width, y: origin.y - 30 * height)

        let path = UIBezierPath()
        // bottom center
        path.move(to: CGPoint(x: origin.x, y: origin.y + 5 * height))
        // left bottom
        path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        // left top
        path.addLine(to: CGPoint(x: bottomLeft.x + width, y: bottomLeft.y - 5 * height))
        // top center
        path.addLine(to: CGPoint(x: origin.x, y: origin.y - 5 * height))
        // right top
        path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        // right bottom
        path.addLine(to: CGPoint(x: topRight.x + width, y: topRight.y + height))
        path.close()

        checkMark = CAShapeLayer()
        checkMark.frame = self.bounds
        checkMark.path = path.cgPath
        checkMark.fillColor = AthenaPalette.parisGreen.cgColor
        circleView.circle.addSublayer(checkMark)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
