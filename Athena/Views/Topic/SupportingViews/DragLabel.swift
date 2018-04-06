import UIKit

class DragLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
