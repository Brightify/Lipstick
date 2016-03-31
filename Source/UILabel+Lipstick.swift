//
//  UILabel+Lipstick.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 31/03/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, styles: (UILabel -> Void)...) {
        self.init()
        
        self.text = text
        
        styled(with: combine(styles))
    }
}

extension UILabel {
    convenience init(text: String) {
        self.init()
        
        self.text = text
    }
}