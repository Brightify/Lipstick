//
//  UIWindow.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 31/03/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

extension UIWindow {
    public convenience init(frame: CGRect, styles: (UIWindow -> Void)...) {
        self.init(frame: frame)
        
        styled(using: combine(styles))
    }
}