import Foundation
import SwiftyJSON

struct Word {
    var english: String
    var native: String
    var transliteration: String
    var icon: String?

    init(english: String, native: String,
         transliteration: String) {

        self.english = english
        self.native = native
        self.transliteration = transliteration
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

        guard let transliteration = json["transliteration"].string else {
            print("Error parsing game object for key: transliteration")
            return nil
        }

        self.init(english: english, native: native,
                    transliteration: transliteration)
    }
}
