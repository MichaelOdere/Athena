import UIKit

class TrainerCollectionCell: UICollectionViewCell {
    let nameLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNameLabel()
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }

    func setupNameLabel() {
        nameLabel.font =  UIFont.systemFont(ofSize: 20)
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)

        let top = NSLayoutConstraint(item: nameLabel,
                                     attribute: NSLayoutAttribute.top,
                                     relatedBy: NSLayoutRelation.equal,
                                     toItem: self,
                                     attribute: NSLayoutAttribute.top,
                                     multiplier: 1,
                                     constant: 0)
        top.isActive = true

        let bottom = NSLayoutConstraint(item: nameLabel,
                                        attribute: NSLayoutAttribute.bottom,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: self,
                                        attribute: NSLayoutAttribute.bottom,
                                        multiplier: 1,
                                        constant: 0)
        bottom.isActive = true

        let trailing = NSLayoutConstraint(item: nameLabel,
                                          attribute: NSLayoutAttribute.trailing,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: self,
                                          attribute: NSLayoutAttribute.trailing,
                                          multiplier: 1,
                                          constant: 0)
        trailing.isActive = true

        let leading = NSLayoutConstraint(item: nameLabel,
                                         attribute: NSLayoutAttribute.leading,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self,
                                         attribute: NSLayoutAttribute.leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
