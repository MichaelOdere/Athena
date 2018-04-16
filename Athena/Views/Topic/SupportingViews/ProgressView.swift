import UIKit

class ProgresView: UIView {
    var progressView: UIProgressView!
    var titleLabel: UILabel!
    var topicTitle: String! {
        didSet {
            titleLabel.text = topicTitle + ": \(percentageComplete * 100)%"
        }
    }

    var percentageComplete: Float! {
        didSet {
            progressView.progress = percentageComplete

            let percentFormatter = NumberFormatter()
            percentFormatter.numberStyle = NumberFormatter.Style.percent
            percentFormatter.minimumFractionDigits = 0
            percentFormatter.maximumFractionDigits = 2

            titleLabel.text = percentFormatter.string(from: NSNumber(value: percentageComplete))!
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initProgressView()
        initTitleLabel()

        topicTitle = ""
        percentageComplete = 0.0

        backgroundColor = UIColor.clear
    }

    func initProgressView() {
        progressView = UIProgressView()
        addSubview(progressView)

        progressView.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: progressView,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: 0)
        top.isActive = true

        let leading = NSLayoutConstraint(item: progressView,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: progressView,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .trailing,
                                         multiplier: 1,
                                         constant: 0)
        trailing.isActive = true
    }

    func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: titleLabel,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: progressView,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: 0)
        top.isActive = true

        let bottom = NSLayoutConstraint(item: titleLabel,
                                     attribute: .bottom,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: 0)
        bottom.isActive = true

        let leading = NSLayoutConstraint(item: titleLabel,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: titleLabel,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: 0)
        trailing.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
