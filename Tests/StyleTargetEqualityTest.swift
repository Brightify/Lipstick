//
//  StyleTargetEqualityTest.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import Quick
import Nimble
@testable import Lipstick

class StyleTargetEqualityTest: QuickSpec {
    override func spec() {
        describe("StyleTargetEquality") {
            it("different names positions should be equal") {
                let targetA = StyleTarget(type: BaseMockStyleable.self, names: ["hello", "world"])
                let targetB = StyleTarget(type: BaseMockStyleable.self, names: ["world", "hello"])
                
                expect(targetA == targetB) == true
            }
        }
        
    }
}