//
//  UIEdgeInsets+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class UIEdgeInsetsInitTest: XCTestCase {
    
    func testInit() {
        XCTAssertEqual(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), UIEdgeInsets())
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1), UIEdgeInsets(1))
        XCTAssertEqual(UIEdgeInsets(top: 2, left: 1, bottom: 2, right: 1), UIEdgeInsets(horizontal: 1, vertical: 2))
        
        XCTAssertEqual(UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1), UIEdgeInsets(horizontal: 1))
        XCTAssertEqual(UIEdgeInsets(top: 2, left: 1, bottom: 0, right: 1), UIEdgeInsets(horizontal: 1, top: 2))
        XCTAssertEqual(UIEdgeInsets(top: 0, left: 1, bottom: 2, right: 1), UIEdgeInsets(horizontal: 1, bottom: 2))
        XCTAssertEqual(UIEdgeInsets(top: 2, left: 1, bottom: 3, right: 1), UIEdgeInsets(horizontal: 1, top: 2, bottom: 3))
        
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0), UIEdgeInsets(vertical: 1))
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 0), UIEdgeInsets(vertical: 1, left: 2))
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 2), UIEdgeInsets(vertical: 1, right: 2))
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 3), UIEdgeInsets(vertical: 1, left: 2, right: 3))

        XCTAssertEqual(UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0), UIEdgeInsets(top: 1))
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 1, bottom: 0, right: 0), UIEdgeInsets(top: 1, left: 1))
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0), UIEdgeInsets(top: 1, bottom: 1))
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 1), UIEdgeInsets(top: 1, right: 1))
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 0), UIEdgeInsets(top: 1, left: 1, bottom: 1))
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 1, bottom: 0, right: 1), UIEdgeInsets(top: 1, left: 1, right: 1))
        XCTAssertEqual(UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 1), UIEdgeInsets(top: 1, bottom: 1, right: 1))
        
        XCTAssertEqual(UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0), UIEdgeInsets(left: 1))
        XCTAssertEqual(UIEdgeInsets(top: 0, left: 1, bottom: 1, right: 0), UIEdgeInsets(left: 1, bottom: 1))
        XCTAssertEqual(UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1), UIEdgeInsets(left: 1, right: 1))
        XCTAssertEqual(UIEdgeInsets(top: 0, left: 1, bottom: 1, right: 1), UIEdgeInsets(left: 1, bottom: 1, right: 1))
        
        XCTAssertEqual(UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0), UIEdgeInsets(bottom: 1))
        XCTAssertEqual(UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 1), UIEdgeInsets(bottom: 1, right: 1))
        
        XCTAssertEqual(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 1), UIEdgeInsets(right: 1))
    }
}
