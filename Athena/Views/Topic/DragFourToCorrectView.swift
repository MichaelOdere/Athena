import UIKit

class DragFourToCorrectView: TopicView {
    var dragView: DragFiveView!

    var gl: CAGradientLayer!
    var colors = [AthenaPalette.lightBlue.cgColor, AthenaPalette.turquoise.cgColor]
    weak var delegate: DoneHandlerProtocol? {
        didSet {
            dragView.delegate = delegate
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initGradientColor(colors: colors)
        initDragFiveView()
    }

    func initDragFiveView() {
        let mainFrame = CGRect(x: frame.width / 10, y: frame.height / 8,
                               width: frame.width * 0.8, height: frame.height * 0.7)
        dragView = DragFiveView(frame: mainFrame)
        dragView.backgroundColor = UIColor.clear
        addSubview(dragView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
