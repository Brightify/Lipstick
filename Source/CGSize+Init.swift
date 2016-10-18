//
//  CGSize+Init.swift
//  Lipstick
//
//  Created by Filip Dolnik on 16.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

extension CGSize {
    
    public init(_ both: CGFloat) {
        self.init(width: both, height: both)
    }
    
    public init(width: CGFloat = 0, height: CGFloat = 0) {
        self.width = width
        self.height = height
    }
}
