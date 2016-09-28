//
//  StylingUtils.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 24/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import UIKit

postfix operator %

public postfix func %(input: CGFloat) -> CGFloat {
    return input / 100
}

func adjust(_ value: CGFloat, by amount: CGFloat) -> CGFloat {
    return min(max(0, value + value * amount), 1)
}

public func insets(_ all: CGFloat) -> UIEdgeInsets {
    return insets(horizontal: all, vertical: all)
}

public func insets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> UIEdgeInsets {
    return insets(left: horizontal, top: vertical, right: horizontal, bottom: vertical)
}

public func insets(left: CGFloat = 0, top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> UIEdgeInsets {
    return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
}

public func size(_ both: CGFloat) -> CGSize {
    return size(width: both, height: both)
}

public func size(width: CGFloat = 0, height: CGFloat = 0) -> CGSize {
    return CGSize(width: width, height: height)
}

public func point(_ both: CGFloat) -> CGPoint {
    return point(x: both, y: both)
}

public func point(x: CGFloat = 0, y: CGFloat = 0) -> CGPoint {
    return CGPoint(x: x, y: y)
}

public func rect(x: CGFloat = 0, y: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

public func font(_ name: String, _ size: CGFloat) -> UIFont {
    return FontCache.fontNamed(name, size: size)
}

public func font(_ descriptor: UIFontDescriptor, _ size: CGFloat) -> UIFont {
    return FontCache.fontDescribedBy(descriptor, size: size)
}

public func image(_ name: String) -> UIImage? {
    return UIImage(named: name)
}

public func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
    return rgba(red, green, blue, 1)
}

public func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
}

public func hsl(_ hue: CGFloat, _ saturation: CGFloat, _ brightness: CGFloat) -> UIColor {
    return hsla(hue, saturation, brightness, 1)
}

public func hsla(_ hue: CGFloat, _ saturation: CGFloat, _ brightness: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
}

public func offset(_ horizontal: CGFloat, vertical: CGFloat) -> UIOffset {
    return UIOffset(horizontal: horizontal, vertical: vertical)
}

public func + (lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
    return lhs.concatenating(rhs)
}

public func rotate(_ degrees: CGFloat) -> CGAffineTransform {
    return CGAffineTransform(rotationAngle: degrees)
}

public func translate(_ tx: CGFloat, _ ty: CGFloat) -> CGAffineTransform {
    return CGAffineTransform(translationX: tx, y: ty)
}

public func scale(_ sx: CGFloat, _ sy: CGFloat) -> CGAffineTransform {
    return CGAffineTransform(scaleX: sx, y: sy)
}

public func darken(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    return lighten(color, -percent)
}

public func lighten(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0
    
    if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
        brightness = adjust(brightness, by: percent)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    } else if color.getWhite(&brightness, alpha: &alpha) {
        brightness = adjust(brightness, by: percent)
        return UIColor(white: brightness, alpha: alpha)
    } else {
        return color
    }
}

public func saturate(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0
    
    if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
        saturation = adjust(saturation, by: percent)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    } else if color.getWhite(&brightness, alpha: &alpha) {
        saturation = adjust(saturation, by: percent)
        return UIColor(white: brightness, alpha: alpha)
    } else {
        return color
    }
}

public func desaturate(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    return desaturate(color, -percent)
}

public func fadein(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0
    
    if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
        alpha = adjust(alpha, by: percent)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    } else if color.getWhite(&brightness, alpha: &alpha) {
        alpha = adjust(alpha, by: percent)
        return UIColor(white: brightness, alpha: alpha)
    } else {
        return color
    }
}

public func fadeout(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    return fadein(color, -percent)
}

public func color(_ hexString: String) -> UIColor {
    return ColorCache.colorFromHex(hexString)
}
