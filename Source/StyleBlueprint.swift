//
//  StyleBlueprint.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 08/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

struct StyleBlueprint {
    enum SingleTargetOrAll {
        case Single(StyleTarget), All
    }
    
    let styling: Styleable -> ()
    var chains: [StyleTarget: (target: StyleTarget, parents: [StyleTarget])] = [:]
    var commonParents: [StyleTarget] = []
    var currentTarget: SingleTargetOrAll {
        didSet {
            if case .Single(let target) = currentTarget {
                // Let's assume that everytime currentTarget is set, we don't know it yet. It should add some performance.
                chains[target] = (target: target, parents: [])
            }
        }
    }
    var currentParents: [StyleTarget] {
        if case .Single(let target) = currentTarget {
            return chains[target]?.parents ?? []
        }
        return []
    }
    
    mutating func addParent(newParent: StyleTarget) {
        switch currentTarget {
        case .Single(let target):
            chains[target]?.parents.append(newParent)
        case .All:            
            for (key, value) in chains {
                chains[key] = (value.target, value.parents.arrayByAppending(newParent))
            }
        }
    }
    
    init(styling: Styleable -> ()) {
        self.styling = styling
        
        currentTarget = .All
    }
    
    init(firstTarget: StyleTarget, styling: Styleable -> ()) {
        self.styling = styling
        
        currentTarget = .Single(firstTarget)
        chains[firstTarget] = (target: firstTarget, parents: [])
    }
}