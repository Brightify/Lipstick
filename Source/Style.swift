//
//  Style.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 07/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

struct Style {
    static let nonMatchingPrecedence: UInt = 0
    
    let index: UInt
    let inside: [StyleTarget]
    let target: StyleTarget
    let styling: Styleable -> ()
    
    func precedence(manager: StyleManager, item: StyledItem) -> UInt {
        var precedence: UInt = 0
        if !target.names.isEmpty {
            if !target.names.intersect(item.styleable.skt_names).isEmpty {
                precedence += 100000
            } else {
                return Style.nonMatchingPrecedence
            }
        }
        
        if !inside.isEmpty {
            var currentItem: StyledItem? = item.getParent(manager)
            // We need to go up the tree
            for parent in inside {
                while let unwrappedItem = currentItem {
                    if parent.matches(unwrappedItem) {
                        break
                    }
                    currentItem = unwrappedItem.getParent(manager)
                }
                
                if currentItem == nil {
                    return Style.nonMatchingPrecedence
                }
                
                currentItem = currentItem?.getParent(manager)
                precedence += 1000000
            }
            
        }
        
        // We need to do better with the precedence
        return precedence + index
    }

    static func typeEraseStylingFunction<T: Styleable>(styling: T -> ()) -> Styleable -> () {
        let typeErasedStyling: Styleable -> () = {
            guard let castStyleable = $0 as? T else {
                fatalError("There is a bug in StyleKit. This should not be allowed!")
            }
            styling(castStyleable)
        }
        
        return typeErasedStyling
    }

}

// MARK: - CustomStringConvertible
extension Style: CustomStringConvertible {
    var description: String {
        return ([target] + inside).reverse().reduce((output: "", separator: "")) {
            let output = $0.output + ($0.output.isEmpty ? "" : "\n") + $0.separator + $1.description
            return (output: output, separator: $0.separator == "" ? "  └> " : "    \($0.separator)")
            }.output
    }
}