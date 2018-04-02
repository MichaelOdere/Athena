import UIKit

class DragThreeView: DragView {
    var top: UILabel!
    var bottom: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initTop()
        initDragWord()
        initBottom()

        labels = [top, bottom]
        setup()
    }

    func setup() {
        hideLabels()
        animateLabels()
    }

    func initTop() {
        let topCenter =  dragOrigin.x + size.width / 2
        let initFrame = CGRect(x: topCenter, y: originTopLeft.y, width: size.width, height: size.height)
        top = UILabel(frame: initFrame)
        top.backgroundColor = UIColor.clear
        top.textColor = UIColor.white
        top.textAlignment = .center
        top.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        addSubview(top)
    }

    func initBottom() {
        let bottomCenter =  dragOrigin.x + size.width / 2
        let initFrame = CGRect(x: bottomCenter, y: originBototmRight.y, width: size.width, height: size.height)
        bottom = UILabel(frame: initFrame)
        bottom.backgroundColor = UIColor.clear
        bottom.textColor = UIColor.white
        bottom.textAlignment = .center
        bottom.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        addSubview(bottom)
    }

    func initDragWord() {
        let initFrame = CGRect(x: dragOrigin.x, y: dragOrigin.y, width: size.width * scale, height: size.height * scale)
        dragWord = UILabel(frame: initFrame)
        dragWord.backgroundColor = UIColor.clear
        dragWord.textColor = UIColor.white
        dragWord.textAlignment = .center
        dragWord.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize + 20)
        dragCenter = dragWord.center
        addSubview(dragWord)
    }

    // nativeWords includes the native word of the word we are sent
    func setText(word: Word, nativeWords: [String]) {
        self.word = word

        let shuffledNativeWords = shuffleArray(arr: nativeWords)

        var count = 0
        for label in labels {
            label.text = shuffledNativeWords[count]
            count += 1
        }
        dragWord.text = word.native
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
