//
//  ColorCache.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 24/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import UIKit

struct ColorCache {
    fileprivate static var cache: [String: UIColor] = [:]
    
    static func colorFromHex(_ hexString: String) -> UIColor {
        if let cachedColor = cache[hexString] {
            return cachedColor
        } else {
            let color = UIColor(hexString: hexString)
            cache[hexString] = color
            return color
        }
    }
}

extension UIColor {
    
    convenience init(hexString: String) {
        let hexNumber = String(hexString.characters.dropFirst())
        precondition(hexNumber.characters.count == 6, "Hex string \(hexString) has to be in format #RRGGBB !")
        guard let hexValue = Int(hexNumber, radix: 16) else {
            preconditionFailure("Hex string \(hexString) could not be parsed!")
        }
        
        let red: CGFloat = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green: CGFloat = CGFloat((hexValue & 0xFF00) >> 8) / 255.0
        let blue: CGFloat = CGFloat(hexValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
