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

    public init(width: CGFloat) {
        self.init(width: width, height: 0)
    }

    public init(height: CGFloat) {
        self.init(width: 0, height: height)
    }
}
