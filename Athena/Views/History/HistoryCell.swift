import UIKit

class HistoryCell: UITableViewCell {
    var accuracyLabel: UILabel!
    var nativeLabel: UILabel!
    var englishLabel: UILabel!
    var strengthView: UIProgressView!
    let padding: CGFloat = 10.0

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initaccuracyLabel()
        initNative()
        initEnglish()
        initStrength()
    }

    func initaccuracyLabel() {
        accuracyLabel = UILabel()
        accuracyLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
        accuracyLabel.textColor = UIColor.white
        accuracyLabel.textAlignment = .left
        addSubview(accuracyLabel)

        accuracyLabel.translatesAutoresizingMaskIntoConstraints = false

        let leading = NSLayoutConstraint(item: accuracyLabel,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: padding)
        leading.isActive = true

        let top = NSLayoutConstraint(item: accuracyLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .top,
                                         multiplier: 1,
                                         constant: 0)
        top.isActive = true

        let bottom = NSLayoutConstraint(item: accuracyLabel,
                                     attribute: .bottom,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: 0)
        bottom.isActive = true
    }

    func initNative() {
        nativeLabel = UILabel()
        nativeLabel.font = UIFont(name: "HelveticaNeue", size: 20.0)
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .left
        addSubview(nativeLabel)

        nativeLabel.translatesAutoresizingMaskIntoConstraints = false

        let leading = NSLayoutConstraint(item: nativeLabel,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: accuracyLabel,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 8 * padding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: nativeLabel,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .trailing,
                                         multiplier: 1,
                                         constant: -8 * padding)
        trailing.isActive = true

        let top = NSLayoutConstraint(item: nativeLabel,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: 2 * padding)
        top.isActive = true

    }

    func initEnglish() {
        englishLabel = UILabel()
        englishLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        englishLabel.textColor = UIColor.white
        englishLabel.textAlignment = .left
        addSubview(englishLabel)

        englishLabel.translatesAutoresizingMaskIntoConstraints = false

        let leading = NSLayoutConstraint(item: englishLabel,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: nativeLabel,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: englishLabel,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: nativeLabel,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: 0)
        trailing.isActive = true

        let top = NSLayoutConstraint(item: englishLabel,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: nativeLabel,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: padding)
        top.isActive = true
    }

    func initStrength() {
        strengthView = UIProgressView()
        addSubview(strengthView)

        strengthView.translatesAutoresizingMaskIntoConstraints = false

        let leading = NSLayoutConstraint(item: strengthView,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: nativeLabel,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: strengthView,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: nativeLabel,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: 0)
        trailing.isActive = true

        let top = NSLayoutConstraint(item: strengthView,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: englishLabel,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: padding)
        top.isActive = true

        let bottom = NSLayoutConstraint(item: strengthView,
                                     attribute: .bottom,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: -2 * padding)
        bottom.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
