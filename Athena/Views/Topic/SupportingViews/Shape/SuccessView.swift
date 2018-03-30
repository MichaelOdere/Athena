import UIKit

class SuccessView: UIView {
    var circleView: CircleView!
    var checkMark: CAShapeLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCheckMark()
    }

    func initCheckMark() {
        let width = frame.width * 0.2
        let height = frame.height * 0.1
        let topLeftPoint = CGPoint(x: 0, y: frame.height * 0.1)
        let bottomRightPoint = CGPoint(x: frame.width, y: frame.height * 0.9)

        let path = UIBezierPath()
        path.move(to: topLeftPoint)
        path.addLine(to: CGPoint(x: topLeftPoint.x + width, y: topLeftPoint.y + height))
        path.addLine(to: bottomRightPoint)
        path.addLine(to: CGPoint(x: bottomRightPoint.x + width, y: bottomRightPoint.y + height))
        path.close()

        checkMark = CAShapeLayer()
        checkMark.frame = self.bounds
        checkMark.path = path.cgPath
        checkMark.fillColor = UIColor.blue.cgColor
        self.layer.addSublayer(checkMark)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
 CGPathMoveToPoint(path, nil, 171 - offsetX, 405 - offsetY)
 CGPathAddLineToPoint(path, nil, 117 - offsetX, 341 - offsetY)
 CGPathAddLineToPoint(path, nil, 325 - offsetX, 138 - offsetY)
 CGPathAddLineToPoint(path, nil, 377 - offsetX, 228 - offsetY)
 CGPathAddLineToPoint(path, nil, 683 - offsetX, 635 - offsetY)
 CGPathAddLineToPoint(path, nil, 590 - offsetX, 677 - offsetY)
 CGPathAddLineToPoint(path, nil, 320 - offsetX, 297 - offsetY)

 */
