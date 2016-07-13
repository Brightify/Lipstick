//
//  Styleable.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

public protocol Styleable: class {
    func applyStyle(style: Self -> Void)
}

extension Styleable {
    public typealias Style = Self -> Void
    
    public func applyStyle(style: Style) {
        style(self)
    }
    
    public func applyStyles(styles: Style...) {
        applyStyles(styles)
    }
    
    public func applyStyles(styles: [Style]) {
        styles.forEach(applyStyle)
    }
    
    public func styled(using styles: Style...) -> Self {
        return styled(using: styles)
    }
    
    public func styled(using styles: [Style]) -> Self {
        styles.forEach {
            applyStyle($0)
        }
        return self
    }
}
