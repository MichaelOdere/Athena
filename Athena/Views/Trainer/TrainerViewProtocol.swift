protocol TrainerViewProtocol {
    var name: String? {get}
    var words: [Word]! {get set}
    func setup()
}
