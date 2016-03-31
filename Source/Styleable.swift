//
//  Styleable.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

public protocol Styleable {
    
    init()
    
    func styled(with styling: Self -> Void)
    
}

extension Styleable {
    public init(styles: (Self -> Void)...) {
        self.init()
        
        styled(with: combine(styles))
    }
    
    public func styled(with styling: Self -> Void) {
        styling(self)
    }
}