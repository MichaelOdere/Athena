import UIKit

class HistoryHeaderView: UIView {
    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.white
        layer.cornerRadius = 20

        initTitleLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        let centerY = NSLayoutConstraint(item: titleLabel,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        centerY.isActive = true

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
}
