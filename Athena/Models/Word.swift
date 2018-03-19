import Foundation
import SwiftyJSON

struct Word {
    var english: String
    var native: String
    var language: Language
    var transliteration: String
    var audioFile: String?

    init(english: String, native: String,
         language: Language, transliteration: String, audioFile: String?) {

        self.english = english
        self.native = native
        self.language = language
        self.transliteration = transliteration
        self.audioFile = audioFile
    }
}

extension Word {
    init?(json: JSON) {
        guard let english = json["english"].string else {
            print("Error parsing game object for key: english")
            return nil
        }

        guard let native = json["native"].string else {
            print("Error parsing game object for key: native")
            return nil
        }

        guard let language = json["language"].language else {
            print("Error parsing game object for key: language")
            return nil
        }

        guard let transliteration = json["transliteration"].string else {
            print("Error parsing game object for key: transliteration")
            return nil
        }

        guard let audioFile = json["audioFile"].string else {
            print("Error parsing game object for key: audioFile")
            return nil
        }

        self.init(english: english, native: native, language: language,
                    transliteration: transliteration, audioFile: audioFile)
    }

}

extension JSON {
    public var language: Language? {
        get {
            if self.string == Language.english.rawValue {
                return .english
            }

            if self.string == Language.hebrew.rawValue {
                return .hebrew
            }

            if self.string == Language.russian.rawValue {
                return .russian
            }

            if self.string == Language.spanish.rawValue {
                return .spanish
            }

            return nil
        }
    }
}
