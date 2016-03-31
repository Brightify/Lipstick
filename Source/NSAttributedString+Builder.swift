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
    mutableString.appendAttributedString(rhs)
    return mutableString
}

public func + (lhs: String, rhs: NSAttributedString) -> NSAttributedString {
    return lhs.attributed() + rhs
}

public func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
    return lhs + rhs.attributed()
}

public enum Attribute {
    case Font(UIFont)
    case ParagraphStyle(NSParagraphStyle)
    case ForegroundColor(UIColor)
    case BackgroundColor(UIColor)
    case Ligature(Int)
    case Kern(Float)
    case StriketroughStyle(NSUnderlineStyle)
    case UnderlineStyle(NSUnderlineStyle)
    case StrokeColor(UIColor)
    case StrokeWidth(Float)
    case Shadow(NSShadow)
    case TextEffect(String)
    case Attachment(NSTextAttachment)
    case LinkURL(NSURL)
    case Link(String)
    case BaselineOffset(Float)
    case UnderlineColor(UIColor)
    case StrikethroughColor(UIColor)
    case Obliqueness(Float)
    case Expansion(Float)
    case WritingDirection(NSWritingDirection)
    case VerticalGlyphForm(Int)
    
    public var name: String {
        switch self {
        case .Font:
            return NSFontAttributeName
        case .ParagraphStyle:
            return NSParagraphStyleAttributeName
        case .ForegroundColor:
            return NSForegroundColorAttributeName
        case .BackgroundColor:
            return NSBackgroundColorAttributeName
        case .Ligature:
            return NSLigatureAttributeName
        case .Kern:
            return NSKernAttributeName
        case .StriketroughStyle:
            return NSStrikethroughStyleAttributeName
        case .UnderlineStyle:
            return NSUnderlineStyleAttributeName
        case .StrokeColor:
            return NSStrokeColorAttributeName
        case .StrokeWidth:
            return NSStrokeWidthAttributeName
        case .Shadow:
            return NSShadowAttributeName
        case .TextEffect:
            return NSTextEffectAttributeName
        case .Attachment:
            return NSAttachmentAttributeName
        case .LinkURL:
            return NSLinkAttributeName
        case .Link:
            return NSLinkAttributeName
        case .BaselineOffset:
            return NSBaselineOffsetAttributeName
        case .UnderlineColor:
            return NSUnderlineColorAttributeName
        case .StrikethroughColor:
            return NSStrikethroughColorAttributeName
        case .Obliqueness:
            return NSObliquenessAttributeName
        case .Expansion:
            return NSExpansionAttributeName
        case .WritingDirection:
            return NSWritingDirectionAttributeName
        case .VerticalGlyphForm:
            return NSVerticalGlyphFormAttributeName
        }
    }
    
    public var value: AnyObject {
        switch self {
        case Font(let font):
            return font
        case ParagraphStyle(let style):
            return style
        case ForegroundColor(let color):
            return color
        case BackgroundColor(let color):
            return color
        case Ligature(let ligature):
            return ligature
        case Kern(let kerning):
            return kerning
        case StriketroughStyle(let style):
            return style.rawValue
        case UnderlineStyle(let style):
            return style.rawValue
        case StrokeColor(let color):
            return color
        case StrokeWidth(let width):
            return width
        case Shadow(let shadow):
            return shadow
        case TextEffect(let effect):
            return effect
        case Attachment(let attachment):
            return attachment
        case LinkURL(let url):
            return url
        case Link(let url):
            return url
        case BaselineOffset(let offset):
            return offset
        case UnderlineColor(let color):
            return color
        case StrikethroughColor(let color):
            return color
        case Obliqueness(let obliqueness):
            return obliqueness
        case Expansion(let expansion):
            return expansion
        case WritingDirection(let direction):
            return direction.rawValue
        case VerticalGlyphForm(let form):
            return form
        }
    }
}

extension String {
    public func attributed(attributes: Attribute...) -> NSAttributedString {
        return attributed(attributes)
    }
    
    public func attributed(attributes: [Attribute]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes.toDictionary())
    }
}

public extension SequenceType where Generator.Element == Attribute {
    
    public func toDictionary() -> [String: AnyObject] {
        var attributeDictionary: [String: AnyObject] = [:]
        for attribute in self {
            attributeDictionary[attribute.name] = attribute.value
        }
        return attributeDictionary
    }
    
}