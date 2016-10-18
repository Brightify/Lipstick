//
//  UIOffset+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class UIOffsetInitTest: XCTestCase {
    
    func testInit() {
        XCTAssertEqual(UIOffset(horizontal: 0, vertical: 0), UIOffset())
        XCTAssertEqual(UIOffset(horizontal: 1, vertical: 1), UIOffset(1))
        XCTAssertEqual(UIOffset(horizontal: 1, vertical: 0), UIOffset(horizontal: 1))
        XCTAssertEqual(UIOffset(horizontal: 0, vertical: 1), UIOffset(vertical: 1))
    }
}
