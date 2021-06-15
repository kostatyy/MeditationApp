//
//  UIColor+Ext.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

extension UIColor {
    
    // MARK: - BG COLORS
    static var musicBgColor = UIColor(rgb: 0x5c3c92)
    static var relaxBgColor = UIColor(rgb: 0x077b8a)
    static var dreamBgColor = UIColor(rgb: 0x12a4d9)
    
    static var mainColor = UIColor(rgb: 0x18293d)

    static func toRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
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
            blue: (rgb) & 0xFF
        )
    }
}
