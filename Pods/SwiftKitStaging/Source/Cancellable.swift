//
//  Cancellable.swift
//  BackToTheFuture
//
//  Created by Tadeas Kriz on 24/01/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

/// Protocol to define the opaque type returned from a request
public protocol Cancellable {
    func cancel()
}

/// A token that can be used to cancel requests
public struct CancellableToken: Cancellable {
    let cancelAction: Void -> Void
    
    public init(cancelAction: Void -> Void) {
        self.cancelAction = cancelAction
    }
    
    public func cancel() {
        cancelAction()
    }
}