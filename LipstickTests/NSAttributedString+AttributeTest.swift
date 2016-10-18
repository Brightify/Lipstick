//
//  NSAttributedString+AttributeTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class NSAttributedStringAttributeTest: XCTestCase {
    
    func testPlusAttributedStrings() {
        let string = NSAttributedString(string: "A") + NSAttributedString(string: "B")
        
        XCTAssertEqual(NSAttributedString(string: "AB"), string)
    }
    
    func testStringPlusAttributedString() {
        let string = "A" + NSAttributedString(string: "B")
        
        XCTAssertEqual(NSAttributedString(string: "AB"), string)
    }
    
    func testAttributedStringPlusString() {
        let string = NSAttributedString(string: "A") + "B"
        
        XCTAssertEqual(NSAttributedString(string: "AB"), string)
    }
    
    func testAttributedVararg() {
        let attributes = [Attribute.baselineOffset(1), Attribute.expansion(1)]
        let attributedString = NSAttributedString(string: "A", attributes: attributes.toDictionary())
        
        XCTAssertEqual(attributedString, "A".attributed(attributes))
    }
    
    func testAttributed() {
        let attributedString = NSAttributedString(string: "A", attributes: [Attribute.baselineOffset(1), Attribute.expansion(1)].toDictionary())
        
        XCTAssertEqual(attributedString, "A".attributed(Attribute.baselineOffset(1), Attribute.expansion(1)))
    }
}
