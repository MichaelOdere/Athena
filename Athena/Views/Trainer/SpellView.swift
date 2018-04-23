import UIKit

class SpellView: UIView {

    var word: Word! {
        didSet {
            initWordView()
            initWord()
        }
    }

    var native: String?
    var wordView: NewWordView!
    var textField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initTextField()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeKeyboard)))
    }

    func initWordView() {
        wordView = NewWordView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.4))

        wordView.nativeLabel.text = word.native
        wordView.englishLabel.text = word.english
        wordView.transliterationLabel.text = word.transliteration

        addSubview(wordView)
    }

    func initWord() {
        guard let nativeTemp = word.native?.applyingTransform(.latinToCyrillic, reverse: false) else {
            print("word.native not set")
            return
        }

        native = nativeTemp
    }

    func initTextField() {
        textField = UITextField(frame: CGRect(x: frame.width * 0.05,
                                              y: frame.height * 0.4,
                                              width: frame.width * 0.9,
                                              height: frame.height * 0.1))

        textField.text = ""
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.clear

        textField.layer.borderWidth = 1
        textField.addTarget(self, action: #selector(updateBorder), for: .editingChanged)
        textField.delegate = self

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

        guard let input = textField.text?
            .applyingTransform(.latinToCyrillic, reverse: false)?
            .trimmingCharacters(in: .whitespaces) else {

                print("textField.text not set")
            return false
        }

        if input.count > native.count || input.count == 0 {
            return false
        }

        let index = native.index(native.startIndex, offsetBy: input.count)
        let truncated = String(native[native.startIndex..<index])

        return truncated.forSorting == input.forSorting
    }

    @objc func removeKeyboard() {
        textField.resignFirstResponder()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SpellView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension String {
    var forSorting: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}
