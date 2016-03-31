//
//  ContainerView.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 31/03/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

public class ContainerView: UIView {
    public override func addSubview(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        super.addSubview(view)
    }
    
    public override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
}