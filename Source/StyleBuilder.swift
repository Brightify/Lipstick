//
//  StyleBuilder.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

public protocol StyleBuilder {

    @warn_unused_result
    func inside(type: Styleable.Type, names: Set<String>) -> Self
}

public extension StyleBuilder {
    
    @warn_unused_result
    public func inside(names: Set<String>) -> Self {
        return inside(AnyStyleable.self, names: names)
    }
    
    @warn_unused_result
    public func inside(named name: String, _ otherNames: String...) -> Self {
        return inside(firstName: name, Set(otherNames))
    }
    
    @warn_unused_result
    public func inside(type: Styleable.Type, named names: String...) -> Self {
        return inside(type, names: Set(names))
    }
    
    @warn_unused_result
    private func inside(firstName name: String, _ otherNames: Set<String>) -> Self {
        return inside(otherNames.union([name]))
    }
}

public protocol CollapsibleStyleBuilder: StyleBuilder {
    func style<T: Styleable>(type: T.Type, named names: Set<String>, styling: T -> ())
    
    /** 
    Unfortunately required when we want to do some chaining, because Swift 2.1 cannot declare one generic parameter 
     to be a subclass of another
    */
    @warn_unused_result
    func willStyle<T: Styleable>(baseType: T.Type) -> TypedStyleBuilder<T>
}

// This duplications is because of a bug in Swift where those `inside` methods could not used in if declared in StyleBuilder

public extension CollapsibleStyleBuilder {
    public func style<T: Styleable>(type: T.Type, named names: String..., styling: T -> ()) {
        style(type, named: Set(names), styling: styling)
    }
    
    @warn_unused_result
    public func inside(type: Styleable.Type, named names: String..., _ run: (declare: CollapsibleStyleBuilder) -> ()) {
        let builder = inside(type, names: Set(names))
        run(declare: builder)
    }
    
    @warn_unused_result
    public func inside(named name: String, _ otherNames: String..., _ run: (declare: CollapsibleStyleBuilder) -> ()) {
        let builder = inside(firstName: name, Set(otherNames))
        run(declare: builder)
    }
}

public extension TypedStyleBuilder {
    @warn_unused_result
    public func inside(type: Styleable.Type, named names: String..., _ run: (declare: TypedStyleBuilder) -> ()) {
        let builder = inside(type, names: Set(names))
        run(declare: builder)
    }
    
    @warn_unused_result
    public func inside(named name: String, _ otherNames: String..., _ run: (declare: TypedStyleBuilder) -> ()) {
        let builder = inside(firstName: name, Set(otherNames))
        run(declare: builder)
    }
}