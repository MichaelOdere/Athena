import UIKit

class SwipeWordView: TopicView {

    var card: NewWordView!
	var match: Bool!

    var incorrect: FailView!
    var correct: SuccessView!

    var colors = [AthenaPalette.lightPink.cgColor, AthenaPalette.maximumRed.cgColor]

    weak var delegate: DoneHandlerProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)

        initGradientColor(colors: colors)
		initCard()
		initIncorrect()
		initCorrect()
    }

	func initCard() {
		let initFrame = CGRect(x: frame.width * 0.1, y: frame.height * 0.1,
							   width: frame.width - 2 * frame.width * 0.1, height: frame.height * 0.55)
		card = NewWordView(frame: initFrame)
		card.layer.cornerRadius = card.frame.height * 0.05
		card.layer.masksToBounds = true
		card.backgroundColor = UIColor.black.withAlphaComponent(0.2)
		addSubview(card)
	}

	// Let Learn Topic VC decide if this is going to be a match or not
	func setText(native: String, english: String, match: Bool) {
		self.match = match
		card.nativeLabel.text = native
		card.englishLabel.text = english
	}

	func initIncorrect() {
		let incorrectFrame = CGRect(x: frame.width * 0.15, y: card.frame.height + frame.height * 0.15,
									width: frame.width * 0.2, height: frame.width * 0.2)
		incorrect = FailView(frame: incorrectFrame)
		incorrect.circleView.circle.fillColor = UIColor.clear.cgColor
		incorrect.circleView.circle.strokeColor = UIColor.white.cgColor
		incorrect.slantLeft.fillColor = UIColor.white.cgColor
		incorrect.slantRight.fillColor = UIColor.white.cgColor
		addSubview(incorrect)
	}

	func initCorrect() {
		let correctFrame = CGRect(x: frame.width - frame.width * 0.15 - frame.width * 0.25,
								  y: card.frame.height + frame.height * 0.15,
								  width: frame.width * 0.2, height: frame.width * 0.2)
		correct = SuccessView(frame: correctFrame)
		correct.circleView.circle.fillColor = UIColor.clear.cgColor
		correct.circleView.circle.strokeColor = UIColor.white.cgColor
		correct.checkMark.fillColor = UIColor.white.cgColor
		correct.checkMark.strokeColor = UIColor.white.cgColor
		addSubview(correct)

	}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
