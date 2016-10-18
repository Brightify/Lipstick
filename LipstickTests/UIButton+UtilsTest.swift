//
//  UIButton+UtilsTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class UIButtonUtilsTest: XCTestCase {
    
    func testInit() {
        let view = UIButton(title: "title")
        
        XCTAssertEqual("title", view.title(for: UIControlState()))
    }
    
    func testSetBackgroundColor() {
        let button = UIButton()
        let controlState = UIControlState.highlighted
        
        button.setBackgroundColor(UIColor.green, forState: controlState)
        
        let image = button.backgroundImage(for: controlState)
        if let pixelData = image?.cgImage?.dataProvider?.data, let data = CFDataGetBytePtr(pixelData) {
            let r = CGFloat(data[0]) / 255
            let g = CGFloat(data[1]) / 255
            let b = CGFloat(data[2]) / 255
            let a = CGFloat(data[3]) / 255
            XCTAssertEqual(UIColor.green, UIColor(red: r, green: g, blue: b, alpha: a))
            XCTAssertEqual(CGSize(1), image?.size)
        } else {
            XCTFail("Cannot find color of background image.")
        }
    }
}
