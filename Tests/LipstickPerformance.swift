//
//  StyleKitPerformance.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 06/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import XCTest
@testable import Lipstick

private class StyledView: UIView { }

private class NoncanonicalView: UIView { }

class LipstickPerformance: XCTestCase {
    
    func testPerformanceExample() {
        self.measureBlock {
            MockStylesheet.with { declare in
                for _ in 1...1000 {
                    declare.style(UIWindow.self) {
                        $0.tintColor = brown
                    }
                    
                    declare.style(UIView.self) {
                        $0.backgroundColor = red
                    }
                    
                    declare.style(UIView.self) {
                        $0.backgroundColor = purple
                    }
                    
                    declare.style(UIButton.self) {
                        $0.backgroundColor = white
                    }
                    
                    declare.inside(UIView).style(UIButton.self) {
                        $0.backgroundColor = blue
                    }
                    
                    declare.inside(StyledView.self, named: "testing").inside(UIView).style(UIButton.self) {
                        $0.backgroundColor = green
                    }
                    
                    declare.style(StyledView.self, named: "hello") {
                        $0.backgroundColor = blue
                    }
                    
                    declare.style(StyledView.self, named: "world") {
                        $0.clipsToBounds = false
                    }
                    
                    declare.style(StyledView.self) {
                        $0.backgroundColor = red
                        $0.clipsToBounds = true
                    }
                    
                    declare.inside(StyledView.self, named: "testing").inside(UIView).inside(UIView).inside(UIView).inside(UIView).inside(UIView).inside(UIView).inside(UIView).style(UIButton.self) {
                        $0.backgroundColor = green
                    }
                    
                    declare.style(StyledView.self) {
                        $0.backgroundColor = red
                        $0.clipsToBounds = true
                    }
                }
            }
            
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.makeKeyAndVisible()
            let v1 = StyledView()
            window.addSubview(v1)
            v1.skt_names = ["testing"]
            let view = UIView()
            let button = UIButton()
            
            v1.addSubview(view)
            view.addSubview(button)
            
            let canonicalView = StyledView()
            canonicalView.skt_names = ["hello", "world"]
            let noncanonicalView = NoncanonicalView()
            
            for _ in 1...100 {
                StyleManager.instance.apply(window)
                StyleManager.instance.apply(canonicalView)
                StyleManager.instance.apply(noncanonicalView)
            }
            
        }
    }
}

