import UIKit

class DragThreeView: DragView {
    var top: DragLabel!
    var bottom: DragLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initTop()
        initcenterWord()
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
        top = DragLabel(frame: initFrame)
        addSubview(top)
    }

    func initBottom() {
        let bottomCenter =  dragOrigin.x + size.width / 2
        let initFrame = CGRect(x: bottomCenter, y: originBototmRight.y, width: size.width, height: size.height)
        bottom = DragLabel(frame: initFrame)
        addSubview(bottom)
    }

    func initcenterWord() {
        let initFrame = CGRect(x: dragOrigin.x, y: dragOrigin.y, width: size.width * scale, height: size.height * scale)
        centerWord = DragLabel(frame: initFrame)
        centerWord.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize + 20)
        dragCenter = centerWord.center
        addSubview(centerWord)
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
        centerWord.text = word.native
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
