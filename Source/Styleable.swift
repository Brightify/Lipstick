//
//  Styleable.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

/// Marker to be used as a wildcard. Can also be used as a type-erasing wrapper.
public class StyleableWrapper<T: Styleable>: AnyStyleable {
    let wrapped: T
    
    public init(_ wrapped: T) {
        self.wrapped = wrapped
        
        super.init(wrapped)
    }
}

public protocol Styleable: class {
    var skt_stylingDetails: StylingDetails { get }
    
    var skt_names: Set<String> { get set }
    
    var skt_parent: Styleable? { get }
    
    var skt_children: [Styleable] { get }
}

public extension Styleable {
    public var skt_names: Set<String> {
        get {
            return skt_stylingDetails.names
        }
        set {
            skt_stylingDetails.names = newValue
        }
    }
    
}

/// MARK: - StylingHandler shortcuts
public extension Styleable {
    public var skt_spaceSeparatedNames: String {
        get {
            return skt_stylingDetails.spaceSeparatedNames
        }
        set {
            skt_stylingDetails.spaceSeparatedNames = newValue
        }
    }
    
    public func skt_addNames(newNamesString: String, animated: Bool = false) {
        skt_stylingDetails.addNames(newNamesString, animated: animated)
    }
    
    public func skt_addNames<S: SequenceType where S.Generator.Element == String>(newNames: S, animated: Bool = false) {
        skt_stylingDetails.addNames(newNames, animated: animated)
    }
    
    public func skt_removeNames(oldNamesString: String, animated: Bool = false) {
        skt_stylingDetails.removeNames(oldNamesString, animated: animated)
    }
    
    public func skt_removeNames<S: SequenceType where S.Generator.Element == String>(oldNames: S, animated: Bool = false) {
        skt_stylingDetails.removeNames(oldNames, animated: animated)
    }
    
    public func skt_setNames(namesString: String, animated: Bool = false) {
        skt_stylingDetails.setNames(namesString, animated: animated)
    }
    
    public func skt_setNames<S: SequenceType where S.Generator.Element == String>(names: S, animated: Bool = false) {
        skt_stylingDetails.setNames(names, animated: animated)
    }
}

/// MARK: - Internal 
extension Styleable {
    internal var manager: StyleManager? {
        return skt_stylingDetails.manager
    }
    
    internal static func isSupertypeOf(type: Styleable.Type) -> Bool {
        return type is Self.Type
    }
    
    internal static func named(name: String) -> (type: Self.Type, named: String) {
        return (type: self, named: name)
    }
}