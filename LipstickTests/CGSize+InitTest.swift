//
//  CGSize+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class CGSizeInitTest: XCTestCase {
    
    func testInit() {
        XCTAssertEqual(CGSize(width: 0, height: 0), CGSize())
        XCTAssertEqual(CGSize(width: 1, height: 1), CGSize(1))
        XCTAssertEqual(CGSize(width: 1, height: 0), CGSize(width: 1))
        XCTAssertEqual(CGSize(width: 0, height: 1), CGSize(height: 1))
    }
}
