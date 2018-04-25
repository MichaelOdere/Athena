import UIKit

class NewWordView: UIView {
    var nativeLabel: DragLabel!
    var transliterationLabel: DragLabel!
    var englishLabel: DragLabel!

    let fontSize: CGFloat = 80
    let fontMultiplier: CGFloat = 0.6

    override init(frame: CGRect) {
        super.init(frame: frame)

        initNativeLabel()
        initEnglishLabel()
        initTransliterationLabelLabel()
    }

    func initNativeLabel() {
        nativeLabel = DragLabel()
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
        englishLabel = DragLabel()
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

    func initTransliterationLabelLabel() {
        transliterationLabel = DragLabel()
        addSubview(transliterationLabel)

        transliterationLabel.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: transliterationLabel,
                                        attribute: .top,
                                        relatedBy: .equal,
                                        toItem: nativeLabel,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: 1)
        top.isActive = true

        let bottom = NSLayoutConstraint(item: transliterationLabel,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: englishLabel,
                                        attribute: .top,
                                        multiplier: 1,
                                        constant: -1)
        bottom.isActive = true

        let leading = NSLayoutConstraint(item: transliterationLabel,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: transliterationLabel,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: 0)
        trailing.isActive = true
    }

    func setText(word: Word) {
        nativeLabel.text = word.native
        englishLabel.text = word.english
        transliterationLabel.text = word.transliteration
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
