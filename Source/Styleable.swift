//
//  Styleable.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

public protocol Styleable: class { }

extension Styleable {
    public typealias Style = (Self) -> Void
    
    public func apply(style: Style) {
        style(self)
    }
    
    public func apply(styles: Style...) {

    }
    
    public func apply(styles: [(Self) -> Void]) {
        styles.forEach(apply)
    }
    
    public func styled(using styles: Style...) -> Self {
        return self // styled(using: styles)
    }
    
    public func styled(using styles: [Style]) -> Self {
        apply(styles: styles)
        return self
    }
}
