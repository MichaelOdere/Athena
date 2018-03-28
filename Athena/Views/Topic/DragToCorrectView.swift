import UIKit

class DragToCorrectView: UIView {
    var dragView: DragFiveView!
    var progressView: ProgresView!
    var horizontalPadding: CGFloat = 0

    var gl: CAGradientLayer!

    weak var delegate: DoneHandlerProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        horizontalPadding = frame.width * 0.1

        initGradientColor()
        initDragFiveView()
        initProgressView()

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DragToCorrectView.switchView)))
    }

    func initGradientColor() {
        gl = CAGradientLayer()
        gl.frame = self.frame
        gl.colors = [AthenaPalette.lightBlue.cgColor, AthenaPalette.turquoise.cgColor]
        gl.locations = [0.0, 1.0]
        self.layer.addSublayer(gl)
    }

    func initDragFiveView() {
        let mainFrame = CGRect(x: frame.width / 10, y: frame.height / 8, width: frame.width * 0.8, height: frame.height * 0.7)
        dragView = DragFiveView(frame: mainFrame)
        dragView.backgroundColor = UIColor.clear
        addSubview(dragView)

//        dragView.translatesAutoresizingMaskIntoConstraints = false
//
//        let top = NSLayoutConstraint(item: dragView,
//                                     attribute: .top,
//                                     relatedBy: .equal,
//                                     toItem: self,
//                                     attribute: .top,
//                                     multiplier: 1,
//                                     constant: 0)
//        top.isActive = true
//
//        let leading = NSLayoutConstraint(item: dragView,
//                                         attribute: .leading,
//                                         relatedBy: .equal,
//                                         toItem: self,
//                                         attribute: .leading,
//                                         multiplier: 1,
//                                         constant: horizontalPadding)
//        leading.isActive = true
//
//        let trailing = NSLayoutConstraint(item: dragView,
//                                         attribute: .trailing,
//                                         relatedBy: .equal,
//                                         toItem: self,
//                                         attribute: .trailing,
//                                         multiplier: 1,
//                                         constant: -horizontalPadding)
//        trailing.isActive = true
    }

    func initProgressView() {
        progressView = ProgresView()//frame: CGRect(x: 0, y: 100 + frame.height * 3/5, width: frame.width, height: 100))
        progressView.percentageComplete = 0.66
        progressView.topicTitle = "Alphabet!"
        addSubview(progressView)

        progressView.translatesAutoresizingMaskIntoConstraints = false

        let bottom = NSLayoutConstraint(item: progressView,
                                     attribute: .bottom,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: -20)
        bottom.isActive = true

        let leading = NSLayoutConstraint(item: progressView,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: horizontalPadding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: progressView,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: -horizontalPadding)
        trailing.isActive = true

        let height = NSLayoutConstraint(item: progressView,
                                          attribute: .height,
                                          relatedBy: .equal,
                                          toItem: nil,
                                          attribute: .height,
                                          multiplier: 1,
                                          constant: frame.height / 10)
        height.isActive = true
    }

    @objc func switchView() {
        delegate?.nextView(tag: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
