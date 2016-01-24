//
//  StyleTest.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 11/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import Quick
import Nimble
@testable import Lipstick

class LipstickDescriptionsTest: QuickSpec {
    override func spec() {
        describe("Style") {
            let index: UInt = 10
            let inside: [StyleTarget] = [
                StyleTarget(type: ChildBMockStyleable.self, names: []),
                StyleTarget(type: ChildAMockStyleable.self, names: []),
                StyleTarget(type: BaseMockStyleable.self, names: ["hello"])
            ]
            let target: StyleTarget = StyleTarget(type: ChildCMockStyleable.self, names: ["name1", "name2"])
            let styling: Styleable -> Void = { _ in }
            let style = Style(index: index, inside: inside, target: target, styling: styling)
            
            it("has readable description") {
                expect(style.description) ==
                    "BaseMockStyleable named: \"hello\"\n" +
                    "  └> ChildAMockStyleable\n" +
                    "      └> ChildBMockStyleable\n" +
                    "          └> ChildCMockStyleable named: \"name1\" or \"name2\""
            }
        }
        
        describe("StyleManager") {
            var parentOuter: ChildBMockStyleable!
            var parentInner: BaseMockStyleable!
            var child: ChildAMockStyleable!

            beforeEach {
                MockStylesheet.with { declare in
                    declare.inside(named: "hello").inside(BaseMockStyleable.self).style(ChildAMockStyleable.self) { _ in }
                }
                
                parentOuter = ChildBMockStyleable()
                parentInner = BaseMockStyleable()
                child = ChildAMockStyleable()
                
                parentOuter.addChild(parentInner)
                parentInner.addChild(child)
                
                StyleManager.instance.apply(parentOuter)
            }
            
            it("has readable description") {
                expect(StyleManager.instance.description) ==
                    "1 declared styles: ---------------\n" +
                    "AnyStyleable named: \"hello\"\n" +
                    "  └> BaseMockStyleable\n" +
                    "      └> ChildAMockStyleable"
            }
            
            it("has verbose debug description") {
                expect(StyleManager.instance.debugDescription) ==
                    "1 declared styles: ---------------\n" +
                    "AnyStyleable named: \"hello\"\n" +
                    "  └> BaseMockStyleable\n" +
                    "      └> ChildAMockStyleable\n\n" +
                    "1 canonical types: ---------------\n" +
                    "  ChildAMockStyleable\n\n" +
                    "3 cached canonical types (type = canonical type): ---------------\n" +
                    "  BaseMockStyleable = BaseMockStyleable\n" +
                    "  ChildAMockStyleable = ChildAMockStyleable\n" +
                    "  ChildBMockStyleable = ChildBMockStyleable"
            }
        }
    }
}