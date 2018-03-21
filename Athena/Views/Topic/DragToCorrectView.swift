import UIKit

class DragToCorrectView: UIView {
    weak var delegate: DoneHandlerProtocol?
    var dragView: DragFiveView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.gray
        dragView = DragFiveView(frame: frame)
        addSubview(dragView)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DragToCorrectView.switchView)))
    }

    @objc func switchView() {
        delegate?.nextView(tag: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
