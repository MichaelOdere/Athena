import UIKit

class SpellView: UIView {

    var word: Word! {
        didSet {
            initWordView()

            guard let nativeTemp = word.native?.applyingTransform(.latinToCyrillic, reverse: false) else {
                print("word.native not set")
                return
            }

            native = nativeTemp
        }
    }
    var native: String?
    var wordView: NewWordView!
    var textField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        inittextField()
    }

    func initWordView() {
        wordView = NewWordView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.4))

        wordView.nativeLabel.text = word.native
        wordView.englishLabel.text = word.english
        wordView.transliterationLabel.text = word.transliteration

        addSubview(wordView)
    }

    func inittextField() {
        textField = UITextField(frame: CGRect(x: 0, y: frame.height * 0.4,
                                            width: frame.width,
                                            height: frame.height * 0.1))

        textField.text = ""
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.clear

        textField.layer.borderWidth = 1
        textField.addTarget(self, action: #selector(updateBorder), for: .editingChanged)

        addSubview(textField)
    }

    @objc func updateBorder() {
        if check() {
            textField.layer.borderColor = UIColor.green.cgColor
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
        }
    }

    func check() -> Bool {
        guard let native = native else {
            return false
        }

        guard let input = textField.text?.applyingTransform(.latinToCyrillic, reverse: false) else {
            print("textField.text not set")
            return false
        }

        if input.count > native.count || input.count == 0 {
            print("false")
            return false
        }

        let index = native.index(native.startIndex, offsetBy: input.count)
        let truncated = String(native[native.startIndex..<index])

        return truncated.forSorting == input.forSorting

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//extension SpellView: UITextFieldDelegate {
//    textdidch
//}

extension String {
    var forSorting: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}
