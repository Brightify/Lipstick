//
//  ContainerView.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 31/03/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

open class ContainerView: UIView {
    open override func addSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        super.addSubview(view)
    }
    
    open override class var requiresConstraintBasedLayout : Bool {
        return true
    }
}
