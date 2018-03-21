import UIKit

class DragFiveView: UIView {

    var topLeft: UILabel!
    var topRight: UILabel!
    var dragWord: UILabel!
    var bottomLeft: UILabel!
    var bottomRight: UILabel!

    let fontSize: CGFloat = 80

    override init(frame: CGRect) {
        super.init(frame: frame)
        initTopLeft()
        initTopRight()
        initDragWord()
        initBottomLeft()
        initBottomRight()
    }

    func initTopLeft() {
        topLeft = UILabel()
        topLeft.backgroundColor = UIColor.red
        topLeft.textColor = UIColor.white
        topLeft.textAlignment = .center
        topLeft.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)

        addSubview(topLeft)

        topLeft.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: topLeft,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: 0)
        top.isActive = true

        let leading = NSLayoutConstraint(item: topLeft,
                                     attribute: .leading,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .leading,
                                     multiplier: 1,
                                     constant: 0)
        leading.isActive = true
    }

    func initTopRight() {
        topRight = UILabel()
        topRight.backgroundColor = UIColor.blue
        topRight.textColor = UIColor.white
        topRight.textAlignment = .center
        topRight.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)

        addSubview(topRight)

        topRight.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: topRight,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: 0)
        top.isActive = true

        let leading = NSLayoutConstraint(item: topRight,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: topLeft,
                                         attribute: .trailing,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: topRight,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .trailing,
                                         multiplier: 1,
                                         constant: 0)
        trailing.isActive = true

        let height = NSLayoutConstraint(item: topRight,
                                          attribute: .height,
                                          relatedBy: .equal,
                                          toItem: topLeft,
                                          attribute: .height,
                                          multiplier: 1,
                                          constant: 0)
        height.isActive = true

        let width = NSLayoutConstraint(item: topRight,
                                          attribute: .width,
                                          relatedBy: .equal,
                                          toItem: topLeft,
                                          attribute: .width,
                                          multiplier: 1,
                                          constant: 0)
        width.isActive = true
    }

    func initDragWord() {
        dragWord = UILabel()
        dragWord.backgroundColor = UIColor.white
        dragWord.textColor = UIColor.white
        dragWord.textAlignment = .center
        dragWord.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize + 20)

        addSubview(dragWord)

        dragWord.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: dragWord,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: topRight,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: 0)
        top.isActive = true

        let centerX = NSLayoutConstraint(item: dragWord,
                                          attribute: .centerX,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .centerX,
                                          multiplier: 1,
                                          constant: 0)
        centerX.isActive = true

        let centerY = NSLayoutConstraint(item: dragWord,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        centerY.isActive = true

        let height = NSLayoutConstraint(item: topLeft,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: dragWord,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 0)
        height.isActive = true

        let width = NSLayoutConstraint(item: topLeft,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: dragWord,
                                       attribute: .width,
                                       multiplier: 1,
                                       constant: 0)
        width.isActive = true
    }

    func initBottomLeft() {
        bottomLeft = UILabel()
        bottomLeft.backgroundColor = UIColor.blue
        bottomLeft.textColor = UIColor.white
        bottomLeft.textAlignment = .center
        bottomLeft.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)

        addSubview(bottomLeft)

        bottomLeft.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: bottomLeft,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: dragWord,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: 0)
        top.isActive = true

        let bottom = NSLayoutConstraint(item: bottomLeft,
                                     attribute: .bottom,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: 0)
        bottom.isActive = true

        let leading = NSLayoutConstraint(item: bottomLeft,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let height = NSLayoutConstraint(item: bottomLeft,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: topLeft,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 0)
        height.isActive = true

        let width = NSLayoutConstraint(item: bottomLeft,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: topLeft,
                                       attribute: .width,
                                       multiplier: 1,
                                       constant: 0)
        width.isActive = true
    }

    func initBottomRight() {
        bottomRight = UILabel()
        bottomRight.backgroundColor = UIColor.red
        bottomRight.textColor = UIColor.white
        bottomRight.textAlignment = .center
        bottomRight.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)

        addSubview(bottomRight)

        bottomRight.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: bottomRight,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: dragWord,
                                     attribute: .bottom,
                                     multiplier: 1,
                                     constant: 0)
        top.isActive = true

        let bottom = NSLayoutConstraint(item: bottomRight,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: 0)
        bottom.isActive = true

        let leading = NSLayoutConstraint(item: bottomRight,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: bottomLeft,
                                         attribute: .trailing,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: bottomRight,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .trailing,
                                         multiplier: 1,
                                         constant: 0)
        trailing.isActive = true

        let height = NSLayoutConstraint(item: bottomRight,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: bottomLeft,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 0)
        height.isActive = true

        let width = NSLayoutConstraint(item: bottomRight,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: bottomLeft,
                                       attribute: .width,
                                       multiplier: 1,
                                       constant: 0)
        width.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
