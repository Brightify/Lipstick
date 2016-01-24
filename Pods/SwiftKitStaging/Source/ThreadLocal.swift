//
//  ThreadLocal.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 13/10/15.
//  Copyright © 2015 Tadeas Kriz. All rights reserved.
//

import Foundation

public class ThreadLocal<T: AnyObject>: ThreadLocalParametrized<Void, T> {
    
    public convenience init(create: () -> T) {
        self.init(id: NSUUID().UUIDString, create: create)
    }
    
    public override init(id: String, create: () -> T) {
        super.init(id: id, create: create)
    }
    
    public func get() -> T {
        return super.get()
    }
}

public class ThreadLocalParametrized<PARAMS, T: AnyObject> {
    private let id: String
    private let create: PARAMS -> T
    
    public convenience init(create: PARAMS -> T) {
        self.init(id: NSUUID().UUIDString, create: create)
    }
    
    public init(id: String, create: PARAMS -> T) {
        self.id = id
        self.create = create
    }
    
    public func get(parameters: PARAMS) -> T {
        if let cachedObject = NSThread.currentThread().threadDictionary[id] as? T {
            return cachedObject
        } else {
            let newObject = create(parameters)
            set(newObject)
            return newObject
        }
    }
    
    public func set(value: T) {
        NSThread.currentThread().threadDictionary[id] = value
    }
    
    public func remove() {
        NSThread.currentThread().threadDictionary.removeObjectForKey(id)
    }
    
}