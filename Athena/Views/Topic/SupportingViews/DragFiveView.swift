import UIKit

class DragFiveView: DragView {
    var topLeft: DragLabel!
    var topRight: DragLabel!
    var bottomLeft: DragLabel!
    var bottomRight: DragLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initTopLeft()
        initTopRight()
        initcenterWord()
        initBottomLeft()
        initBottomRight()

        labels = [topLeft, topRight, bottomLeft, bottomRight]
        setup()
    }

    func setup() {
        hideLabels()
        animateLabels()
    }

    func initTopLeft() {
        let initFrame = CGRect(x: originTopLeft.x, y: originTopLeft.y, width: size.width, height: size.height)
        topLeft = DragLabel(frame: initFrame)
        addSubview(topLeft)
    }

    func initTopRight() {
        let initFrame = CGRect(x: originBototmRight.x, y: originTopLeft.y, width: size.width, height: size.height)
        topRight = DragLabel(frame: initFrame)
        addSubview(topRight)
    }

    func initBottomLeft() {
        let initFrame = CGRect(x: originTopLeft.x, y: originBototmRight.y, width: size.width, height: size.height)
        bottomLeft = DragLabel(frame: initFrame)
        addSubview(bottomLeft)
    }

    func initBottomRight() {
        let initFrame = CGRect(x: originBototmRight.x, y: originBototmRight.y, width: size.width, height: size.height)
        bottomRight = DragLabel(frame: initFrame)
        addSubview(bottomRight)
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
