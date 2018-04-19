import UIKit

class SpellView: UIView {

    var word: Word! {
        didSet {
            initWordView()
            print(word.native == word.native)
        }
    }
    var wordView: NewWordView!
    var textView: UITextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initTextView()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(check)))
    }

    func initWordView() {
        wordView = NewWordView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.4))

        wordView.nativeLabel.text = word.native
        wordView.englishLabel.text = word.english
        wordView.transliterationLabel.text = word.transliteration

        addSubview(wordView)
    }

    func initTextView() {
        textView = UITextView(frame: CGRect(x: 0, y: frame.height * 0.4, width: frame.width, height: frame.height * 0.1))
        textView.backgroundColor = UIColor.red
        textView.text = ""
        addSubview(textView)
    }

    @objc func check() {
        print(textView.text.lowercased())
        var native1 = word.native?.folding(options: .diacriticInsensitive, locale: .current)
        var native2 = textView.text.folding(options: .diacriticInsensitive, locale: .current)

        native1 = native1?.trimmingCharacters(in: .whitespaces)
        native2 = native2.trimmingCharacters(in: .whitespaces)

        print(native1!.lowercased() == native2.lowercased())

        print(native1!.localizedCaseInsensitiveCompare(native2) == .orderedSame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
