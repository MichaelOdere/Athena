import UIKit

class FlashCardsView: UIView, TrainerViewProtocol {
    // Required for the TrainerViewProtocol
    var name: String?
    var words: [Word]!

    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        name = "Flash Cards"
        words = []
        initCollectionView()
    }

    func setup() {
        collectionView.reloadData()
    }

    func initCollectionView() {
        collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: frame.height * 0.1,
                                                        width: frame.width,
                                                        height: frame.height *  0.9),
                                          collectionViewLayout: FlashCardCollectionViewLayout())

        collectionView.register(TrainerCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.clear

        collectionView.delegate = self
        collectionView.dataSource = self

        addSubview(collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlashCardsView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let word = words[indexPath.row]

        var cell: TrainerCollectionCell!

        if let dqCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            as? TrainerCollectionCell {
            cell = dqCell
        } else {
            cell = TrainerCollectionCell()
        }

        cell.nameLabel.text = word.english
        return cell
    }
}
