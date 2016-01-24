//
//  StyleKitMatchingTest.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import Quick
import Nimble
@testable import Lipstick

struct MockStylesheet: Stylesheet {
    
    let declaration: CollapsibleStyleBuilder -> Void
    
    init(declaration: CollapsibleStyleBuilder -> Void) {
        self.declaration = declaration
    }
    
    func declareStyles(declare: CollapsibleStyleBuilder) {
        declaration(declare)
    }
    
    static func with(managerType: StyleManager.Type = StyleManager.self, destroyManager: Bool = true, declaration: CollapsibleStyleBuilder -> Void) {
        let stylesheet = MockStylesheet(declaration: declaration)
        
        if destroyManager {
            managerType.destroyInstance()
        }
        managerType.instance.addStylesheet(stylesheet)
    }
    
}

protocol MockStyleable: Styleable {
    var parentMock: MockStyleable? { get set }
    
    var mockChildren: [MockStyleable] { get set }
    
    var styleIndices: [Int] { get }
    
    func addChild(child: MockStyleable)
    
    func removeFromParent()
    
    func styled(index: Int)
}

extension MockStyleable {
    var styledTimes: Int {
        return styleIndices.count
    }
}

class BaseMockStyleable: MockStyleable {
    lazy var skt_stylingDetails: StylingDetails = StylingDetails(styledItem: self)
    
    var skt_parent: Styleable? {
        return parentMock
    }
    
    var skt_children: [Styleable] {
        return mockChildren.map { $0 }
    }
    
    var parentMock: MockStyleable?
    
    var mockChildren: [MockStyleable] = []
    
    var styleIndices: [Int] = []
    
    func addChild(child: MockStyleable) {
        precondition(child.skt_parent == nil, "Child cannot have a parent")
        
        child.parentMock = self
        mockChildren.append(child)
    }
    
    func removeFromParent() {
        if let index = parentMock?.skt_children.indexOf({ $0 === self }) {
            parentMock?.mockChildren.removeAtIndex(index)
        }
        parentMock = nil
    }
    
    func styled(index: Int) {
        styleIndices.append(index)
    }
    
    static func style(index: Int = 0)(item: MockStyleable) {
        item.styled(index)
    }
}

class ChildAMockStyleable: BaseMockStyleable { }

class ChildBMockStyleable: BaseMockStyleable { }

class ChildCMockStyleable: BaseMockStyleable { }

class StyleKitMatchingTest: QuickSpec {
    override func spec() {
        describe("StyleKit matching") {
            it("matches single item with or without name") {
                // given
                MockStylesheet.with { declare in
                    declare.style(BaseMockStyleable.self, styling: BaseMockStyleable.style())
                }
                let item = BaseMockStyleable()
                let namedItem = BaseMockStyleable()
                namedItem.skt_names = ["hello"]
  
                // when
                StyleManager.instance.apply(item)
                StyleManager.instance.apply(namedItem)
                
                // then
                expect(item.styledTimes) == 1
                expect(namedItem.styledTimes) == 1
            }
            
            it("matches single named item and ignores unnamed") {
                // given
                MockStylesheet.with { declare in
                    declare.style(BaseMockStyleable.self, named: "hello", styling: BaseMockStyleable.style())
                }
                let item = BaseMockStyleable()
                let namedItem = BaseMockStyleable()
                namedItem.skt_names = ["hello"]
                
                // when
                StyleManager.instance.apply(item)
                StyleManager.instance.apply(namedItem)
                
                // then
                expect(item.styledTimes) == 0
                expect(namedItem.styledTimes) == 1
            }
            
            it("matches item noncanonical subclasses") {
                // given
                MockStylesheet.with { declare in
                    declare.style(BaseMockStyleable.self, styling: BaseMockStyleable.style())
                }
                let base = BaseMockStyleable()
                let childA = ChildAMockStyleable()
                let childB = ChildBMockStyleable()
                
                // when
                StyleManager.instance.apply(base)
                StyleManager.instance.apply(childA)
                StyleManager.instance.apply(childB)
                
                // then
                expect(base.styledTimes) == 1
                expect(childA.styledTimes) == 1
                expect(childB.styledTimes) == 1
            }
            
            it("matches item noncanonical subclasses but not canonical") {
                // given
                MockStylesheet.with { declare in
                    declare.style(BaseMockStyleable.self, styling: BaseMockStyleable.style(1))
                    declare.style(ChildAMockStyleable.self, styling: BaseMockStyleable.style(2))
                }
                let base = BaseMockStyleable()
                let childA = ChildAMockStyleable()
                let childB = ChildBMockStyleable()
                
                // when
                StyleManager.instance.apply(base)
                StyleManager.instance.apply(childA)
                StyleManager.instance.apply(childB)
                
                // then
                expect(base.styledTimes) == 1
                expect(childA.styledTimes) == 1
                expect(childB.styledTimes) == 1
                
                expect(base.styleIndices) == [1]
                expect(childA.styleIndices) == [2]
                expect(childB.styleIndices) == [1]
            }
            
            it("matches item inside parent") {
                // given
                MockStylesheet.with { declare in
                    declare.inside(BaseMockStyleable.self) { declare in
                        declare.style(BaseMockStyleable.self, styling: BaseMockStyleable.style())
                    }
                }
                let parent = BaseMockStyleable()
                let child = BaseMockStyleable()
                parent.addChild(child)
                let independent = BaseMockStyleable()
                
                // when
                StyleManager.instance.apply(parent, includeChildren: false)
                StyleManager.instance.apply(child, includeChildren: false)
                StyleManager.instance.apply(independent, includeChildren: false)
                
                // then
                expect(parent.styledTimes) == 0
                expect(child.styledTimes) == 1
                expect(independent.styledTimes) == 0
            }
            
            it("matches item inside parent subtype") {
                // given
                MockStylesheet.with { declare in
                    declare.inside(BaseMockStyleable).style(BaseMockStyleable.self, styling: BaseMockStyleable.style(1))
                    declare.style(ChildAMockStyleable.self, styling: BaseMockStyleable.style(2))
                }
                let parent = ChildAMockStyleable()
                let child = BaseMockStyleable()
                parent.addChild(child)
                let independent = BaseMockStyleable()
                
                // when
                StyleManager.instance.apply(parent, includeChildren: false)
                StyleManager.instance.apply(child, includeChildren: false)
                StyleManager.instance.apply(independent, includeChildren: false)
                
                // then
                expect(parent.styledTimes) == 1
                expect(child.styledTimes) == 1
                expect(independent.styledTimes) == 0
                
                expect(parent.styleIndices) == [2]
                expect(child.styleIndices) == [1]
                expect(independent.styleIndices) == []
            }
            
            it("matches inside multiple parents") {
                // given
                MockStylesheet.with { declare in
                    declare.inside(BaseMockStyleable).inside(ChildAMockStyleable).style(ChildBMockStyleable.self, styling: BaseMockStyleable.style())
                }
                
                let parentOuter = BaseMockStyleable()
                let parentInner = ChildAMockStyleable()
                let child = ChildBMockStyleable()
                
                parentOuter.addChild(parentInner)
                parentInner.addChild(child)
                
                // when
                StyleManager.instance.apply(parentOuter, includeChildren: false)
                StyleManager.instance.apply(parentInner, includeChildren: false)
                StyleManager.instance.apply(child, includeChildren: false)
                
                // then
                expect(parentOuter.styledTimes) == 0
                expect(parentInner.styledTimes) == 0
                expect(child.styledTimes) == 1
            }
            
            it("matches base types") {
                // given
                MockStylesheet.with { declare in
                    declare.style(BaseMockStyleable.self, styling: BaseMockStyleable.style(1))
                    
                    declare.willStyle(BaseMockStyleable).style(ChildAMockStyleable.self).and
                        .style(ChildBMockStyleable.self).using(BaseMockStyleable.style(2))
                }
                let base = BaseMockStyleable()
                let childA = ChildAMockStyleable()
                let childB = ChildBMockStyleable()
                
                // when
                StyleManager.instance.apply(base)
                StyleManager.instance.apply(childA)
                StyleManager.instance.apply(childB)
                
                // then
                expect(base.styledTimes) == 1
                expect(childA.styledTimes) == 1
                expect(childB.styledTimes) == 1
                
                expect(base.styleIndices) == [1]
                expect(childA.styleIndices) == [2]
                expect(childB.styleIndices) == [2]
                
            }
        }

    }
}