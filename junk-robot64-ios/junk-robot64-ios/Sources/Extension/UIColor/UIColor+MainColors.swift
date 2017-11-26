import UIKit

extension UIColor {

    static let mainTintColor = UIColor(rgb: 0x008893)
    static let mainColor = UIColor(rgb: 0x00C5D8)
    static let mainLightGray = UIColor(rgb: 0xFAFAFA)

}

// MARK: - Assistants

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }

    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }

}
