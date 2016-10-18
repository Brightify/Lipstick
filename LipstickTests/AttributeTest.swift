//
//  AttributeTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class AttributeTest: XCTestCase {
    
    func testToDictionary() {
        let attributes = [Attribute.baselineOffset(1), Attribute.expansion(2)].toDictionary()
        
        XCTAssertEqual(1, attributes[NSBaselineOffsetAttributeName] as! Float)
        XCTAssertEqual(2 , attributes[NSExpansionAttributeName] as! Float)
    }
}
