//
//  UILabel+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class UILabelInitTest: XCTestCase {
    
    func testInit() {
        let label = UILabel(text: "text")
        
        XCTAssertEqual("text", label.text)
    }
}
