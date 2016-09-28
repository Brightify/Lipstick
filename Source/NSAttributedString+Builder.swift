//
//  NSAttributedString+Builder.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 26/01/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let mutableString = NSMutableAttributedString(attributedString: lhs)
    mutableString.append(rhs)
    return mutableString
}

public func + (lhs: String, rhs: NSAttributedString) -> NSAttributedString {
    return lhs.attributed() + rhs
}

public func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
    return lhs + rhs.attributed()
}

public enum Attribute {
    case font(UIFont)
    case paragraphStyle(NSParagraphStyle)
    case foregroundColor(UIColor)
    case backgroundColor(UIColor)
    case ligature(Int)
    case kern(Float)
    case striketroughStyle(NSUnderlineStyle)
    case underlineStyle(NSUnderlineStyle)
    case strokeColor(UIColor)
    case strokeWidth(Float)
    case shadow(NSShadow)
    case textEffect(String)
    case attachment(NSTextAttachment)
    case linkURL(URL)
    case link(String)
    case baselineOffset(Float)
    case underlineColor(UIColor)
    case strikethroughColor(UIColor)
    case obliqueness(Float)
    case expansion(Float)
    case writingDirection(NSWritingDirection)
    case verticalGlyphForm(Int)
    
    public var name: String {
        switch self {
        case .font:
            return NSFontAttributeName
        case .paragraphStyle:
            return NSParagraphStyleAttributeName
        case .foregroundColor:
            return NSForegroundColorAttributeName
        case .backgroundColor:
            return NSBackgroundColorAttributeName
        case .ligature:
            return NSLigatureAttributeName
        case .kern:
            return NSKernAttributeName
        case .striketroughStyle:
            return NSStrikethroughStyleAttributeName
        case .underlineStyle:
            return NSUnderlineStyleAttributeName
        case .strokeColor:
            return NSStrokeColorAttributeName
        case .strokeWidth:
            return NSStrokeWidthAttributeName
        case .shadow:
            return NSShadowAttributeName
        case .textEffect:
            return NSTextEffectAttributeName
        case .attachment:
            return NSAttachmentAttributeName
        case .linkURL:
            return NSLinkAttributeName
        case .link:
            return NSLinkAttributeName
        case .baselineOffset:
            return NSBaselineOffsetAttributeName
        case .underlineColor:
            return NSUnderlineColorAttributeName
        case .strikethroughColor:
            return NSStrikethroughColorAttributeName
        case .obliqueness:
            return NSObliquenessAttributeName
        case .expansion:
            return NSExpansionAttributeName
        case .writingDirection:
            return NSWritingDirectionAttributeName
        case .verticalGlyphForm:
            return NSVerticalGlyphFormAttributeName
        }
    }
    
    public var value: AnyObject {
        switch self {
        case .font(let font):
            return font
        case .paragraphStyle(let style):
            return style
        case .foregroundColor(let color):
            return color
        case .backgroundColor(let color):
            return color
        case .ligature(let ligature):
            return ligature as AnyObject
        case .kern(let kerning):
            return kerning as AnyObject
        case .striketroughStyle(let style):
            return style.rawValue as AnyObject
        case .underlineStyle(let style):
            return style.rawValue as AnyObject
        case .strokeColor(let color):
            return color
        case .strokeWidth(let width):
            return width as AnyObject
        case .shadow(let shadow):
            return shadow
        case .textEffect(let effect):
            return effect as AnyObject
        case .attachment(let attachment):
            return attachment
        case .linkURL(let url):
            return url as AnyObject
        case .link(let url):
            return url as AnyObject
        case .baselineOffset(let offset):
            return offset as AnyObject
        case .underlineColor(let color):
            return color
        case .strikethroughColor(let color):
            return color
        case .obliqueness(let obliqueness):
            return obliqueness as AnyObject
        case .expansion(let expansion):
            return expansion as AnyObject
        case .writingDirection(let direction):
            return direction.rawValue as AnyObject
        case .verticalGlyphForm(let form):
            return form as AnyObject
        }
    }
}

extension String {
    public func attributed(_ attributes: Attribute...) -> NSAttributedString {
        return attributed(attributes)
    }
    
    public func attributed(_ attributes: [Attribute]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes.toDictionary())
    }
}

public extension Sequence where Iterator.Element == Attribute {
    
    public func toDictionary() -> [String: AnyObject] {
        var attributeDictionary: [String: AnyObject] = [:]
        for attribute in self {
            attributeDictionary[attribute.name] = attribute.value
        }
        return attributeDictionary
    }
    
}
