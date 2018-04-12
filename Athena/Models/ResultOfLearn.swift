enum ResultOfLearn {
    case none
    case learned(Word)
    case incorrect(Word)
    case correct(Word)
}

extension ResultOfLearn {
    func getWord() -> Word? {
        switch self {
        case .correct(let word):
            return word
        case .incorrect(let word):
            return word
        case .learned(let word):
            return word
        case .none:
            return nil
        }
    }

    func isSameType(res: ResultOfLearn) -> Bool {
        switch self {
        case .none:
            if case .none = res { return true}
        case .correct:
            if case .correct = res { return true}
        case .learned:
            if case .learned = res { return true}
        case .incorrect:
            if case .incorrect = res { return true}
        }

        return false
    }
}
