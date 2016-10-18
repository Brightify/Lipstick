//
//  CGPoint+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class CGPointInitTest: XCTestCase {
    
    func testInit() {
        XCTAssertEqual(CGPoint(x: 0, y: 0), CGPoint())
        XCTAssertEqual(CGPoint(x: 1, y: 1), CGPoint(1))
        XCTAssertEqual(CGPoint(x: 1, y: 0), CGPoint(x: 1))
        XCTAssertEqual(CGPoint(x: 0, y: 1), CGPoint(y: 1))
    }
}
