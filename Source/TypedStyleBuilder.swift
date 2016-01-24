//
//  TypedStyleBuilder.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 08/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

public struct TypedStyleBuilder<BASE: Styleable>: StyleBuilder {
    public typealias StylingCallback = (BASE -> Void) -> Void
    
    let part: StyleDeclarationPart
    
    @warn_unused_result
    public func style(type: BASE.Type, named names: String...) -> DSLHelper__And_Using<TypedStyleBuilder, StylingCallback> {
        let target = StyleTarget(type: type, names: Set(names))
        let nextPart = StyleDeclarationPart.Join(previous: self.part, target: target)
        let builder = TypedStyleBuilder(part: nextPart)
        
        return DSLHelper__And_Using(and: builder, using: { self.part.collapse(type, names: names, styling: $0) })
    }
    
    @warn_unused_result
    public func inside(type: Styleable.Type, names: Set<String>) -> TypedStyleBuilder<BASE> {
        let parent = StyleTarget(type: type, names: names)
        let nextPart = StyleDeclarationPart.Parent(previous: self.part, parent: parent)
        
        return TypedStyleBuilder(part: nextPart)
    }
}

// MARK: - Convenience methods
public extension TypedStyleBuilder {
//    @warn_unused_result
//    public func style(type: BASE.Type, named names: String...) -> DSLHelper__Also_Using<TypedStyleBuilder, StylingCallback> {
//        return style(type, named: Set(names))
//    }
}