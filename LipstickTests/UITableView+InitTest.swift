//
//  UITableView+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class UITableViewInitTest: XCTestCase {
    
    func testInit() {
        let view = UITableView(style: .plain)
        
        XCTAssertEqual(CGRect.zero, view.frame)
        XCTAssertEqual(UITableViewStyle.plain, view.style)
    }
}
