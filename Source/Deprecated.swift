//
//  Deprecated.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

@available(*, deprecated, message: "Replace with: UIEdgeInsets(all)")
public func insets(_ all: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(all)
}

@available(*, deprecated, message: "Replace with: UIEdgeInsets(horizontal: horizontal, vertical: vertical)")
public func insets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> UIEdgeInsets {
    return UIEdgeInsets(horizontal: horizontal, vertical: vertical)
}

@available(*, deprecated, message: "Replace with: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)")
public func insets(left: CGFloat = 0, top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> UIEdgeInsets {
    return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
}

@available(*, deprecated, message: "Replace with: CGSize(both)")
public func size(_ both: CGFloat) -> CGSize {
    return CGSize(both)
}

@available(*, deprecated, message: "Replace with: CGSize(width: width, height: height)")
public func size(width: CGFloat = 0, height: CGFloat = 0) -> CGSize {
    return CGSize(width: width, height: height)
}

@available(*, deprecated, message: "Replace with: CGPoint(both)")
public func point(_ both: CGFloat) -> CGPoint {
    return CGPoint(both)
}

@available(*, deprecated, message: "Replace with: CGPoint(x: x, y: y)")
public func point(x: CGFloat = 0, y: CGFloat = 0) -> CGPoint {
    return CGPoint(x: x, y: y)
}

@available(*, deprecated, message: "Replace with: CGRect(x: x, y: y, width: width, height: height)")
public func rect(x: CGFloat = 0, y: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

@available(*, deprecated, message: "Replace with: UIFont(name, size)")
public func font(_ name: String, _ size: CGFloat) -> UIFont {
    return UIFont(name, size)
}

@available(*, deprecated, message: "Replace with: UIFont(descriptor: descriptor, size: size)")
public func font(_ descriptor: UIFontDescriptor, _ size: CGFloat) -> UIFont {
    return UIFont(descriptor: descriptor, size: size)
}

@available(*, deprecated, message: "Replace with: UIImage(named: name)")
public func image(_ name: String) -> UIImage? {
    return UIImage(named: name)
}

@available(*, deprecated, message: "Replace with: UIColor(rgb)")
public func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
    return rgba(red, green, blue, 1)
}

@available(*, deprecated, message: "Replace with: UIColor(rgba)")
public func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
}

@available(*, deprecated, message: "Replace with: UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)")
public func hsl(_ hue: CGFloat, _ saturation: CGFloat, _ brightness: CGFloat) -> UIColor {
    return hsla(hue, saturation, brightness, 1)
}

@available(*, deprecated, message: "Replace with: UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)")
public func hsla(_ hue: CGFloat, _ saturation: CGFloat, _ brightness: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
}

@available(*, deprecated, message: "Replace with: UIOffset(horizontal: horizontal, vertical: vertical)")
public func offset(_ horizontal: CGFloat, vertical: CGFloat) -> UIOffset {
    return UIOffset(horizontal: horizontal, vertical: vertical)
}

@available(*, deprecated, message: "Replace with: color.darker(by: percent)")
public func darken(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    return color.darker(by: percent)
}

@available(*, deprecated, message: "Replace with: color.lighter(by: percent)")
public func lighten(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    return color.lighter(by: percent)
}

@available(*, deprecated, message: "Replace with: color.saturated(by: percent)")
public func saturate(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    return color.saturated(by: percent)
}

@available(*, deprecated, message: "Replace with: color.desaturated(by: percent)")
public func desaturate(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    return color.desaturated(by: percent)
}

@available(*, deprecated, message: "Replace with: color.fadedIn(by: percent)")
public func fadein(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    return color.fadedIn(by: percent)
}

@available(*, deprecated, message: "Replace with: color.fadedOut(by: percent)")
public func fadeout(_ color: UIColor, _ percent: CGFloat) -> UIColor {
    return color.fadedOut(by: percent)
}

@available(*, deprecated, message: "Replace with: UIColor(hex: hexString)")
public func color(_ hexString: String) -> UIColor {
    return UIColor(hex: hexString)
}

extension UIButton {
    
    @available(*, deprecated, message: "Replace with: UIButton().styled(using: styles)")
    public convenience init(styles: (@escaping (UIButton) -> Void)...) {
        self.init()
        
        apply(styles: styles)
    }
    
    @available(*, deprecated, message: "Replace with: UIButton(title: title).styled(using: styles)")
    public convenience init(title: String, styles: (@escaping (UIButton) -> Void)...) {
        self.init()
        
        self.setTitle(title, for: UIControlState())
        
        apply(styles: styles)
    }
}

extension UICollectionView {
    
    @available(*, deprecated, message: "Replace with: UICollectionView(collectionViewLayout: layout).styled(using: styles)")
    public convenience init(collectionViewLayout layout: UICollectionViewLayout, styles: ((UICollectionView) -> Void)...) {
        self.init(collectionViewLayout: layout)
        
        styles.forEach(apply)
    }
}

extension UILabel {
    
    @available(*, deprecated, message: "Replace with: UILabel(text: text).styled(using: styles)")
    public convenience init(text: String, styles: (@escaping (UILabel) -> Void)...) {
        self.init(text: text)
        
        apply(styles: styles)
    }
}

extension UITableView {
    
    @available(*, deprecated, message: "Replace with: UITableView(style: style).styled(using: styles)")
    public convenience init(style: UITableViewStyle, styles: ((UITableView) -> Void)...) {
        self.init(style: style)
        
        styles.forEach(apply)
    }
}

extension UIWindow {
    
    @available(*, deprecated, message: "Replace with: UIWindow(frame: frame).styled(using: styles)")
    public convenience init(frame: CGRect, styles: (@escaping (UIWindow) -> Void)...) {
        self.init(frame: frame)
        
        apply(styles: styles)
    }
}
