//
//  NSAttributedString+Attribute.swift
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

extension String {
    
    public func attributed(_ attributes: Attribute...) -> NSAttributedString {
        return attributed(attributes)
    }
    
    public func attributed(_ attributes: [Attribute]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes.toDictionary())
    }
}
