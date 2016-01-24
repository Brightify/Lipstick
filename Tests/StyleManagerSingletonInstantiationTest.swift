//
//  StyleKitSingletonInstantiationTest.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 08/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import Quick
import Nimble
@testable import Lipstick

class StyleManagerSingletonInstantiationTest: QuickSpec {
    override func spec() {
        describe("StyleManager") {
            beforeEach {
                StyleManager.destroyInstance()
            }
            it("is StyleManager when accessed in StyleManager") {
                expect(StyleManager.instance.dynamicType === StyleManager.self) == true
            }
            
            it("is UIKitStyleManager when accessed in UIKitStyleManager") {
                expect(UIKitStyleManager.instance.dynamicType === UIKitStyleManager.self) == true
            }
        }
    }
}