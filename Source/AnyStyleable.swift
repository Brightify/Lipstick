//
//  AnyStyleable.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 08/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

/// Marker to be used as a wildcard. Can also be used as a type-erasing wrapper.
public class AnyStyleable: Styleable {
    private let wrapped: Styleable
    
    public var skt_stylingDetails: StylingDetails {
        return wrapped.skt_stylingDetails
    }
    
    public var skt_names: Set<String> {
        get {
            return wrapped.skt_names
        }
        set {
            wrapped.skt_names = newValue
        }
    }
    public var skt_parent: Styleable? {
        return wrapped.skt_parent
    }
    public var skt_children: [Styleable] {
        return wrapped.skt_children
    }
    
    public init(_ wrapped: Styleable) {
        self.wrapped = wrapped
    }
}

