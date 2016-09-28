//
//  UIButton+Lipstick.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 31/03/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

extension UIButton {
    public convenience init(styles: (@escaping (UIButton) -> Void)...) {
        self.init()

        apply(styles: styles)
    }
    
    public convenience init(title: String, styles: (@escaping (UIButton) -> Void)...) {
        self.init()
        
        self.setTitle(title, for: UIControlState())

        apply(styles: styles)
    }
}

extension UIButton {
    public convenience init(title: String) {
        self.init()
        
        setTitle(title, for: UIControlState())
    }
    
    public func setBackgroundColor(_ color: UIColor, forState state: UIControlState) {
        setBackgroundImage(UIButton.imageWithColor(color), for: state)
    }
    
    fileprivate static func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        context?.setFillColor(color.cgColor);
        context?.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image!;
    }
}
