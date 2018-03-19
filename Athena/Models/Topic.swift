struct Topic {
    var name: String
    var icon: String
    var words: [Word]

    init(name: String, icon: String, words: [Word]) {
        self.name = name
        self.icon = icon
        self.words = words
    }
}
