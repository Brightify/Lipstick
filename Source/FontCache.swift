//
//  FontCache.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 24/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import UIKit

struct FontCacheKey: Hashable {
    let descriptor: UIFontDescriptor
    let size: CGFloat
    
    var hashValue: Int {
        var result = 17
        
        result = 31 &* result &+ descriptor.hashValue
        result = 31 &* result &+ size.hashValue
        
        return result
    }
}

func == (lhs: FontCacheKey, rhs: FontCacheKey) -> Bool {
    return lhs.descriptor == rhs.descriptor && lhs.size == rhs.size
}

struct FontCache {
    private static var descriptorCache: [String: UIFontDescriptor] = [:]
    private static var fontCache: [FontCacheKey: UIFont] = [:]
    
    static func fontDescriptorNamed(name: String, size: CGFloat) -> UIFontDescriptor {
        let key = keyForName(name, size: size)
        if let cachedDescriptor = descriptorCache[key] {
            return cachedDescriptor
        } else {
            let descriptor = UIFontDescriptor(name: name, size: size)
            descriptorCache[key] = descriptor
            return descriptor
        }
    }
    
    static func fontNamed(name: String, size: CGFloat) -> UIFont {
        let descriptor = fontDescriptorNamed(name, size: size)
        let key = FontCacheKey(descriptor: descriptor, size: size)
        if let cachedFont = fontCache[key] {
            return cachedFont
        } else {
            let font = UIFont(descriptor: key.descriptor, size: size)
            fontCache[key] = font
            return font
        }
    }
    
    static func fontDescribedBy(descriptor: UIFontDescriptor, size: CGFloat) -> UIFont {
        let key = FontCacheKey(descriptor: descriptor, size: size)
        if let cachedFont = fontCache[key] {
            return cachedFont
        } else {
            let font = UIFont(descriptor: descriptor, size: size)
            fontCache[key] = font
            return font
        }
    }
    
    private static func keyForName(name: String, size: CGFloat) -> String {
        return "\(name)__\(size)"
    }
}