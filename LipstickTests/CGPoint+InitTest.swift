//
//  CGPoint+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import Quick
import Nimble
import Lipstick

class CGPointInitTest: QuickSpec {
    
    override func spec() {
        describe("CGPoint init") {
            it("creates CGPoint") {
                expect(CGPoint()) == CGPoint(x: 0, y: 0)
                expect(CGPoint(1)) == CGPoint(x: 1, y: 1)
                expect(CGPoint(x: 1)) == CGPoint(x: 1, y: 0)
                expect(CGPoint(y: 1)) == CGPoint(x: 0, y: 1)
            }
        }
    }
}
