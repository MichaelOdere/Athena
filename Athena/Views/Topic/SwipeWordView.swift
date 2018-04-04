import UIKit

enum Direction {
	case right
	case left
}
class SwipeWordView: TopicView {

    var card: NewWordView!
	var word: Word!
	var match: Bool!

    var incorrect: FailView!
    var correct: SuccessView!

    var colors = [AthenaPalette.lightPink.cgColor, AthenaPalette.maximumRed.cgColor]

    weak var delegate: DoneHandlerProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)

        initGradientColor(colors: colors)
		initCard()
		initSwipes()
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
	func setText(word: Word, native: String, english: String, match: Bool) {
		self.word = word
		self.match = match
		card.nativeLabel.text = native
		card.englishLabel.text = english
	}

	func initSwipes() {
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(selectIncorrect))
		swipeLeft.direction = UISwipeGestureRecognizerDirection.left
		addGestureRecognizer(swipeLeft)

		let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(selectCorrect))
		swipeRight.direction = UISwipeGestureRecognizerDirection.right
		addGestureRecognizer(swipeRight)
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

		incorrect.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectIncorrect)))
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

		correct.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCorrect)))
	}

	func animateCardDismiss(direction: Direction) {
		let origin = card.frame.origin
		let displacement = self.frame.width

		var xDisplacement: CGFloat!
		var rotation: CGFloat = CGFloat.pi / 4

		switch direction {
		case .right:
			xDisplacement = displacement
		case .left:
			xDisplacement = -displacement
			rotation = -rotation
		}

		UIView.animate(withDuration: animationDuration, animations: {
			// Origin needs to be moves before transform
			self.card.frame.origin = CGPoint(x: origin.x + xDisplacement, y: origin.y)
			self.card.transform =  CGAffineTransform(rotationAngle: rotation)
			self.card.alpha = 0
		}) { (success) in
			// Transform needs to be set to identiy before origin is set
			self.card.transform = CGAffineTransform.identity
			self.card.alpha = 1
			self.card.frame.origin = origin
		}
	}

	@objc func selectIncorrect() {
		animateCardDismiss(direction: .left)
		delegate?.previousView(previous: .swipeWordView, result: getResult(userSelected: false))
	}

	@objc func selectCorrect() {
		animateCardDismiss(direction: .right)
		delegate?.previousView(previous: .swipeWordView, result: getResult(userSelected: true))
	}

	func getResult(userSelected: Bool) -> ResultOfLearn {
		return .incorrect(word)
//		return userSelected == match ? .correct : .incorrect(word)
	}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
