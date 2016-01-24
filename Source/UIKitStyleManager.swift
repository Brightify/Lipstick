//
//  UIKitStyleManager.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 08/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import UIKit

public class UIKitStyleManager: StyleManager {
    
    var initializedWindows: [UIWindow: Bool] = [:]
    
    public required init() {
        super.init()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "lowMemoryWarning:", name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
        notificationCenter.addObserver(self, selector: "windowDidBecomeVisible:", name: UIWindowDidBecomeKeyNotification, object: nil)
        notificationCenter.addObserver(self, selector: "windowDidBecomeVisible:", name: UIWindowDidBecomeVisibleNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: "deviceOrientationWillChange:", name: UIApplicationWillChangeStatusBarOrientationNotification, object: nil)
        notificationCenter.addObserver(self, selector: "deviceOrientationDidChange:", name: UIApplicationDidChangeStatusBarOrientationNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func style(applications: [StyleApplication], animated: Bool) {
        if animated {
            UIView.animateWithDuration(0.33, delay: 0, options: [.BeginFromCurrentState, .LayoutSubviews], animations: {
                super.style(applications, animated: animated)
            }, completion: nil)
        } else {
            super.style(applications, animated: animated)
        }
    }
}

// MARK: - Styling
extension UIKitStyleManager {
    
    func initializeViewHierarchyForView(view: UIView) {
        if let window = view.window {
            initializeViewHierarchyForWindow(window)
        }
    }
    
    func initializeViewHierarchyForWindow(window: UIWindow) {
        // TODO if we not initialized window
        let initialized = initializedWindows[window]
        if initialized == nil || initialized == false {
            initializedWindows[window] = true
            // Not applying styling right away because we will soon get deviceOrientationChanged or windowDidBecomeVisible notification
            scheduleStyleApplication(window, animated: false)
        }
    }
}

// MARK: - Notifications
extension UIKitStyleManager {
    
    @objc func lowMemoryWarning(notification: NSNotification) {
        clearCaches()
    }
    
    @objc func deviceOrientationWillChange(notification: NSNotification) {
        
    }
    
    @objc func deviceOrientationDidChange(notification: NSNotification) {
        
    }
    
    @objc func windowDidBecomeVisible(notification: NSNotification) {
        guard let window = notification.object as? UIWindow else { return }
        initializeViewHierarchyForWindow(window)
    }
    
}