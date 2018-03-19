struct Topic {
    var name: String
    var icon: String
    var wordsLearned: [Word]
    var wordsToLearn: [Word]

    init(name: String, icon: String, wordsLearned: [Word], wordsToLearn: [Word]) {
        self.name = name
        self.icon = icon
        self.wordsLearned = wordsLearned
        self.wordsToLearn = wordsToLearn
    }
}
