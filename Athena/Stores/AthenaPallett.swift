import UIKit

public struct AthenaPalette {
    static public let parisGreen = UIColor(red: 0x52, green: 0xDD, blue: 0x6C)
    static public let maximumBlue = UIColor(red: 0x35, green: 0xA1, blue: 0xCC)
    static public let lightBlue = UIColor(red: 0xAE, green: 0xD4, blue: 0xE6)
    static public let turquoise = UIColor(red: 0x44, green: 0xE5, blue: 0xE7)
    static public let lightPink = UIColor(red: 0xE0, green: 0xBA, blue: 0xD7)
    static public let rasberryPink = UIColor(red: 0xE3, green: 0x63, blue: 0x97)
    static public let maximumRed = UIColor(red: 0xDE, green: 0x1A, blue: 0x1A)
    static public let slate = UIColor(red: 0x08, green: 0x52, blue: 0x6A)
    static public let blue = UIColor(red: 0x4E, green: 0xB8, blue: 0xD3)
    static public let floral = UIColor(red: 0xA6, green: 0x82, blue: 0xFF)
    static public let yankeesBlue = UIColor(red: 0x14, green: 0x1B, blue: 0x41)
}

// https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
