//
//  Stylesheet.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 11/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

public protocol Stylesheet {
    
    /// Implement this method to declare styles of this stylesheet
    func declareStyles(declare: CollapsibleStyleBuilder)
    
}