//
//  UIButton+Lipstick.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 31/03/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(styles: (UIButton -> Void)...) {
        self.init()
        
        styled(with: combine(styles))
    }
    
    convenience init(title: String, styles: (UIButton -> Void)...) {
        self.init()
        
        self.setTitle(title, forState: .Normal)
        
        styled(with: combine(styles))
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init()
        
        setTitle(title, forState: .Normal)
    }
    
    public func setBackgroundColor(color: UIColor, forState state: UIControlState) {
        setBackgroundImage(UIButton.imageWithColor(color), forState: state)
    }
    
    private static func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
}