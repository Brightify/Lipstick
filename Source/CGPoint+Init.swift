//
//  CGPoint+Init.swift
//  Lipstick
//
//  Created by Filip Dolnik on 16.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

extension CGPoint {
    
    public init(_ both: CGFloat) {
        self.init(x: both, y: both)
    }
    
    public init(x: CGFloat = 0, y: CGFloat = 0) {
        self.x = x
        self.y = y
    }
}
