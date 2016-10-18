//
//  UIColor+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class UIColorInitTest: XCTestCase {
    
    func testInitHex() {
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(hex: "#FFFFFF"))
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 1, alpha: 0), UIColor(hex: "#00FFFF00"))
    }
    
    func testInitRgb() {
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(rgb: 0xFFFFFF))
    }
    
    func testInitRgba() {
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 1, alpha: 0), UIColor(rgba: 0x00FFFF00))
    }
}
