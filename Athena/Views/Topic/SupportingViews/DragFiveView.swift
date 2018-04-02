import UIKit

class DragFiveView: DragView {
    var topLeft: UILabel!
    var topRight: UILabel!
    var bottomLeft: UILabel!
    var bottomRight: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initTopLeft()
        initTopRight()
        initDragWord()
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
        topLeft = UILabel(frame: initFrame)
        topLeft.backgroundColor = UIColor.clear
        topLeft.textColor = UIColor.white
        topLeft.textAlignment = .center
        topLeft.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        addSubview(topLeft)
    }

    func initTopRight() {
        let initFrame = CGRect(x: originBototmRight.x, y: originTopLeft.y, width: size.width, height: size.height)
        topRight = UILabel(frame: initFrame)
        topRight.backgroundColor = UIColor.clear
        topRight.textColor = UIColor.white
        topRight.textAlignment = .center
        topRight.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        addSubview(topRight)
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

    func initBottomLeft() {
        let initFrame = CGRect(x: originTopLeft.x, y: originBototmRight.y, width: size.width, height: size.height)
        bottomLeft = UILabel(frame: initFrame)
        bottomLeft.backgroundColor = UIColor.clear
        bottomLeft.textColor = UIColor.white
        bottomLeft.textAlignment = .center
        bottomLeft.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        addSubview(bottomLeft)
    }

    func initBottomRight() {
        let initFrame = CGRect(x: originBototmRight.x, y: originBototmRight.y, width: size.width, height: size.height)
        bottomRight = UILabel(frame: initFrame)
        bottomRight.backgroundColor = UIColor.clear
        bottomRight.textColor = UIColor.white
        bottomRight.textAlignment = .center
        bottomRight.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
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
        dragWord.text = word.native
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
