//
//  DispatchHelpers.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 08/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import Foundation

public func cancellableDispatchAfter(seconds: Double, queue: dispatch_queue_t = dispatch_get_main_queue(), block: () -> ()) -> Cancellable {
    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    return cancellableDispatchAfter(delay, on: queue, block: block)
}

public func cancellableDispatchAfter(time: dispatch_time_t, on queue: dispatch_queue_t, block: () -> ()) -> Cancellable {
    var cancelled: Bool = false
    dispatch_after(time, queue) {
        if cancelled == false {
            block()
        }
    }
    return CancellableToken {
        cancelled = true
    }
}

public func cancellableDispatchAsync(on queue: dispatch_queue_t = dispatch_get_main_queue(), block: () -> ()) -> Cancellable {
    var cancelled: Bool = false
    
    dispatch_async(queue) {
        if cancelled == false {
            block()
        }
    }
    
    return CancellableToken {
        cancelled = true
    }
}