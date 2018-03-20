import UIKit

class NewWordView: UIView {
    var nativeLabel: UILabel!
    var englishLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initNativeLabel()
        initEnglishLabel()
    }

    func initNativeLabel() {
        nativeLabel = UILabel()
        nativeLabel.backgroundColor = UIColor.clear
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        addSubview(nativeLabel)

        nativeLabel.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: nativeLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .top,
                                         multiplier: 1,
                                         constant: 0)
        top.isActive = true

        let height = NSLayoutConstraint(item: nativeLabel,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .height,
                                        multiplier: 1/2,
                                        constant: 0)
        height.isActive = true

        let leading = NSLayoutConstraint(item: nativeLabel,
                                     attribute: .leading,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .leading,
                                     multiplier: 1,
                                     constant: 0)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: nativeLabel,
                                     attribute: .trailing,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .trailing,
                                     multiplier: 1,
                                     constant: 0)
        trailing.isActive = true
    }

    func initEnglishLabel() {
        englishLabel = UILabel()
        englishLabel.backgroundColor = UIColor.clear
        englishLabel.textColor = UIColor.white
        englishLabel.textAlignment = .center
        englishLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        addSubview(englishLabel)

        englishLabel.translatesAutoresizingMaskIntoConstraints = false

        let bottom = NSLayoutConstraint(item: englishLabel,
                                     attribute: .bottom,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: 0)
        bottom.isActive = true

        let height = NSLayoutConstraint(item: englishLabel,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .height,
                                        multiplier: 1/4,
                                        constant: 0)
        height.isActive = true

        let leading = NSLayoutConstraint(item: englishLabel,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: englishLabel,
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
