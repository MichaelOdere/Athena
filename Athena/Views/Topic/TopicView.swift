import UIKit

class TopicView: UIView {
    var progressView: ProgresView!
    var horizontalPadding: CGFloat = 0

    var gl: CAGradientLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        horizontalPadding = frame.width * 0.1
        initProgressView()
    }

    func initProgressView() {
        progressView = ProgresView()
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

    func initGradientColor(colors: [CGColor]) {
        let gl = CAGradientLayer()
        gl.frame = self.frame
        gl.colors = colors
        gl.locations = [0.0, 1.0]
        self.layer.insertSublayer(gl, below: self.progressView.layer)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
