import UIKit

class TopicCell: UITableViewCell {
    var title: UILabel!
    var progress: UIProgressView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initTitle()
        initProgress()
        selectionStyle = .none
    }

    func initTitle() {
        title = UILabel()
        title.font = UIFont(name: "HelveticaNeue-Bold", size: 26.0)
        title.textColor = UIColor.white
        title.textAlignment = .center
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: title,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        centerX.isActive = true

        let centerY = NSLayoutConstraint(item: title,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        centerY.isActive = true
    }

    func initProgress() {
        progress = UIProgressView()
        addSubview(progress)
        progress.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: progress,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        centerX.isActive = true

        let top = NSLayoutConstraint(item: progress,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: title,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: 10)
        top.isActive = true

        let width = NSLayoutConstraint(item: progress,
                                     attribute: .width,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .width,
                                     multiplier: 1/4,
                                     constant: 0)
        width.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
