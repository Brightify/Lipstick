//
//  StyledItem.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

struct StyledItem {
    let canonicalType: Styleable.Type
    let styleable: Styleable
    
    func getParent(manager: StyleManager) -> StyledItem? {
        return styleable.skt_parent.map(manager.styledItem)
    }
}