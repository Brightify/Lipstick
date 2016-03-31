//
//  ContainerView.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 31/03/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    override func addSubview(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        super.addSubview(view)
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
}