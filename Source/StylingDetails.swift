//
//  StylingHandler.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 08/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import SwiftKitStaging

struct ScheduledStyling: Cancellable {
    let includeChildren: Bool
    let animated: Bool
    let cancelAction: Void -> Void
    
    init(includeChildren: Bool, animated: Bool, cancellable: Cancellable) {
        self.init(includeChildren: includeChildren, animated: animated, cancelAction: cancellable.cancel)
    }
    
    init(includeChildren: Bool, animated: Bool, cancelAction: Void -> Void) {
        self.includeChildren = includeChildren
        self.animated = animated
        self.cancelAction = cancelAction
    }
    
    func cancel() {
        cancelAction()
    }
    
}

public class StylingDetails {
    private var _names: Set<String> = []
    public var names: Set<String> {
        get {
            return _names
        }
        set {
            setNamesInternal(newValue)
        }
    }
    public var beforeStyled: (Styleable -> Void)?
    public var afterStyled: (Styleable -> Void)?
    
    let styledItemType: Styleable.Type
    weak var styledItem: Styleable?
    weak var manager: StyleManager?
    var beingStyled: Bool = false
    
    var parentItemStylingDetails: StylingDetails? {
        return styledItem?.skt_parent?.skt_stylingDetails
    }

    // MARK: Caching storage
    weak var lastParent: Styleable?
    var cachedStyleApplication: StyleApplication?
    
    // MARK: Scheduling storage
    var scheduledStyleApplication: ScheduledStyling?
    var stylingScheduled: Bool {
        if scheduledStyleApplication != nil {
            return true
        }
        return parentItemStylingDetails?.stylingScheduled ?? false
    }
    
    // MARK: Initializers
    public init(styledItem: Styleable) {
        self.styledItem = styledItem
        styledItemType = styledItem.dynamicType
    }
}

// MARK: - Cache handling
extension StylingDetails {
    var hasDifferentParent: Bool {
        return styledItem?.skt_parent !== lastParent
    }
    
    func invalidateCachedStyles(includeChildren includeChildren: Bool = true) {
        cachedStyleApplication = nil
        
        if let styledItem = styledItem where includeChildren {
            // We have to pass in `reapply = false`, otherwise we would be doing a lot of unnecessary work
            styledItem.skt_children.forEach { $0.skt_stylingDetails.invalidateCachedStyles() }
        }
    }
}

// MARK: - Names handling
extension StylingDetails {
    public var spaceSeparatedNames: String {
        get {
            return names.joinWithSeparator(" ")
        }
        set {
            setNames(newValue, separator: " ")
        }
    }
    
    public func addNames(newNamesString: String, animated: Bool = false, separator: Character = " ") {
        let newNames = newNamesString.characters.split(separator).map(String.init)
        
        addNames(newNames, animated: animated)
    }
    
    public func addNames<S: SequenceType where S.Generator.Element == String>(newNames: S, animated: Bool = false) {
        setNamesInternal(names.union(newNames), animated: animated)
    }
    
    public func removeNames(oldNamesString: String, animated: Bool = false, separator: Character = " ") {
        let oldNames = oldNamesString.characters.split(separator).map(String.init)
        
        removeNames(oldNames, animated: animated)
    }
    
    public func removeNames<S: SequenceType where S.Generator.Element == String>(oldNames: S, animated: Bool = false) {
        setNamesInternal(names.subtract(oldNames), animated: animated)
    }
    
    public func setNames(namesString: String, animated: Bool = false, separator: Character = " ") {
        let names = namesString.characters.split(separator).map(String.init)
        
        setNames(names, animated: animated)
    }
    
    public func setNames<S: SequenceType where S.Generator.Element == String>(names: S, animated: Bool = false) {
        setNamesInternal(Set(names), animated: animated)
    }
    
    /// Used privately to not require multiple SequenceType conversions to Set
    private func setNamesInternal(names: Set<String>, animated: Bool = false) {
        // If names are not changed, no need to restyle.
        if names == _names {
            return
        }
        
        _names = names
        
        // When we change the names, we have to invalidate the style caches of this styleable and its children
        invalidateCachedStyles()

        guard let manager = manager, styledItem = styledItem else { return }
        manager.scheduleStyleApplication(styledItem, includeChildren: true, animated: animated)
    }
}

// MARK: - CustomStringConvertible
extension StylingDetails: CustomStringConvertible {
    public var description: String {
        var output = "\(styledItemType)"
        
        if !names.isEmpty {
            output += " named: " + names.sort().joinWithSeparator(", ")
        }
        
        if let cachedStyleApplication = cachedStyleApplication {
            output += (
                ["\n  \(cachedStyleApplication.styles.count) cached styles: ---------------"] +
                cachedStyleApplication.styles.map {
                    $0.description.componentsSeparatedByString("\n").joinWithSeparator("\n  ")
                }
            ).joinWithSeparator("\n")
        } else {
            output += "\n  Styles not cached."
        }

        return output
    }
}