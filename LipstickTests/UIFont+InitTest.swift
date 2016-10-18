//
//  UIFont+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest

class UIFontInitTest: XCTestCase {
    
    func testInit() {
        let font = UIFont("HelveticaNeue", 12)
        
        XCTAssertEqual("HelveticaNeue", font.fontName)
        XCTAssertEqual(12, font.pointSize)
    }
}
