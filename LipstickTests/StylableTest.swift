//
//  StylableTest.swift
//  LipstickTests
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class StylableTest: XCTestCase {
    
    private var view: UIView!
    
    override func setUp() {
        view = UIView()
    }
    
    func testApplyStyle() {
        view.apply(style: Styles.background)
        view.apply(style: Styles.tint)
        
        assert(view: view)
    }
    
    func testApplyStylesVararg() {
        view.apply(styles: Styles.background, Styles.tint)
        
        assert(view: view)
    }
    
    func testApplyStyles() {
        view.apply(styles: [Styles.background, Styles.tint])
        
        assert(view: view)
    }
    
    func testStyledVararg() {
        let styledView = view.styled(using: Styles.background, Styles.tint)
        
        assert(view: styledView)
    }
    
    func testStyled() {
        let styledView = view.styled(using: [Styles.background, Styles.tint])
        
        assert(view: styledView)
    }
    
    private func assert(view: UIView, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(UIColor.blue, view.backgroundColor, file: file, line: line)
        XCTAssertEqual(UIColor.black, view.tintColor, file: file, line: line)
    }
}

extension StylableTest {
    
    fileprivate struct Styles {
        
        static func background(_ view: UIView) {
            view.backgroundColor = UIColor.blue
        }
        
        static func tint(_ view: UIView) {
            view.tintColor = UIColor.black
        }
    }
}
