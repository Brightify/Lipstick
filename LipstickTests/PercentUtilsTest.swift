//
//  PercentUtilsTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import Quick
import Nimble
import Lipstick

class PercentUtilsTest: QuickSpec {
    
    override func spec() {
        describe("%") {
            it("returns percents") {
                expect(35%) == 0.35
            }
        }
    }
}
