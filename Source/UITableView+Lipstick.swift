//
//  UIScrollView.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 31/03/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

extension UITableView {
    public convenience init(style: UITableViewStyle, styles: (UITableView -> Void)...) {
        self.init(frame: CGRectZero, style: style)
        
        styled(using: combine(styles))
    }
}