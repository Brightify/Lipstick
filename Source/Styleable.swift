//
//  Styleable.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

public protocol Styleable { }

extension UIView: Styleable { }

public typealias Style<T> = (T) -> Void

extension Styleable {
    
    public func apply(style: Style<Self>) {
        style(self)
    }
    
    public func apply(styles: Style<Self>...) {
        styles.forEach(apply(style:))
    }
    
    public func apply(styles: [Style<Self>]) {
        styles.forEach(apply(style:))
    }
    
    public func styled(using styles: Style<Self>...) -> Self {
        styles.forEach(apply(style:))
        return self
    }
    
    public func styled(using styles: [Style<Self>]) -> Self {
        apply(styles: styles)
        return self
    }
}

