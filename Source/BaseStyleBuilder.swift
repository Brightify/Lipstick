//
//  OffspringChain.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

public struct BaseStyleBuilder: CollapsibleStyleBuilder {

    let part: StyleDeclarationPart
    
    public func style<T: Styleable>(type: T.Type, named names: Set<String>, styling: T -> ()) {
        part.collapse(type, names: names, styling: styling)
    }
    
    public func inside(type: Styleable.Type, names: Set<String>) -> BaseStyleBuilder {
        let parent = StyleTarget(type: type, names: names)
        let nextPart = StyleDeclarationPart.Parent(previous: self.part, parent: parent)
        
        return BaseStyleBuilder(part: nextPart)
    }
    
    public func willStyle<T : Styleable>(baseType: T.Type) -> TypedStyleBuilder<T> {
        let nextPart = StyleDeclarationPart.Base(previous: self.part)
        return TypedStyleBuilder<T>(part: nextPart)
    }
}