//
//  UIKitStyleManagerTest.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 08/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import Quick
import Nimble
@testable import Lipstick

class UIKitStyleManagerTest: QuickSpec {
    override func spec() {
        describe("StyleTargetEquality") {
            beforeEach {
                UIKitStyleManager.destroyInstance()
            }
            
            it("different names positions should be equal") {
                MockStylesheet.with(UIKitStyleManager.self) { declare in
                    
                }
                
                
                
            }
        }
        
    }
}