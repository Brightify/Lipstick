//
//  CGAffineTransform+ShortcutTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class CGAffineTransformShortcutTest: XCTestCase {
    
    func testPlus() {
        XCTAssertEqual(translate(x: 5, y: 3), translate(x: 5) + translate(y: 3))
    }
    
    func testRotate() {
        XCTAssertEqual(CGAffineTransform(rotationAngle: 0), rotate())
        XCTAssertEqual(CGAffineTransform(rotationAngle: 10), rotate(10))
    }
    
    func testTranslate() {
        XCTAssertEqual(CGAffineTransform(translationX: 0, y: 0), translate())
        XCTAssertEqual(CGAffineTransform(translationX: 1, y: 0), translate(x: 1))
        XCTAssertEqual(CGAffineTransform(translationX: 0, y: 1), translate(y: 1))
        XCTAssertEqual(CGAffineTransform(translationX: 1, y: 1), translate(x: 1, y: 1))
    }
    
    func testScale() {
        XCTAssertEqual(CGAffineTransform(scaleX: 1, y: 1), scale())
        XCTAssertEqual(CGAffineTransform(scaleX: 2, y: 1), scale(x: 2))
        XCTAssertEqual(CGAffineTransform(scaleX: 1, y: 2), scale(y: 2))
        XCTAssertEqual(CGAffineTransform(scaleX: 2, y: 2), scale(x: 2, y: 2))
    }
}
