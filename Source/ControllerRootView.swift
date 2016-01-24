//
//  ControllerRootView.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 08/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import UIKit

public class ControllerRootView: UIView {
    
    public let wrappedView: UIView?
    public override var frame: CGRect {
        didSet {
            let frameModified = frame != oldValue
            wrappedView?.frame = bounds
            if frameModified {
                UIKitStyleManager.instance.scheduleStyleApplicationIfNeeded(self, animated: false)
            }
        }
    }
    
    public convenience init() {
        self.init(frame: CGRectZero)
    }
    
    public override init(frame: CGRect) {
        wrappedView = nil
        super.init(frame: frame)
        
        loadView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        wrappedView = nil
        
        super.init(coder: aDecoder)
        
        loadView()
    }
    
    public init(wrap: UIView) {
        wrappedView = wrap
        super.init(frame: CGRectZero)
        
        addSubview(wrap)
    }
    
    private func loadView() {
        autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        if frame == CGRectZero {
            frame = window?.bounds ?? UIScreen.mainScreen().bounds
        }
    }
}

// MARK: - Lifecycle