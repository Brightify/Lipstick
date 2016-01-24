//
//  StyleManager.swift
//  SwiftManager
//
//  Created by Tadeas Kriz on 06/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import SwiftKitStaging

public class StyleManager {
    /// Storage for the `instance` property.
    private static var currentInstanceOrNil: StyleManager?
    
    private var stylesheets: [Stylesheet] = []
    
    private var canonicalTypes: [Styleable.Type] = [] {
        didSet {
            // Each time a canonical type is added or removed, we need to clear the cache because it becomes invalid.
            canonicalTypesCache.removeAll(keepCapacity: true)
        }
    }
    private var canonicalTypesCache: [ObjectIdentifier: (type: Styleable.Type, canonicalType: Styleable.Type)] = [:]
    
    private var index: UInt = 1
    private var styles: [ObjectIdentifier: (canonicalType: Styleable.Type, styles: [Style])] = [:]
    
    public required init() { }
    
    public func addStylesheet(stylesheetInit: Void -> Stylesheet) {
        addStylesheet(stylesheetInit())
    }
    
    public func addStylesheet(stylesheet: Stylesheet) {
        let stylingStarted = NSDate()
        let builder = BaseStyleBuilder(part: .Initial(manager: self))
        
        stylesheets.append(stylesheet)
        
        stylesheet.declareStyles(builder)
        
        print("Stylesheet loaded in", NSDate().timeIntervalSinceDate(stylingStarted), "seconds")
    }
    
    public func apply(styleable: Styleable, includeChildren: Bool = true, animated: Bool = false) {
        let stylingDetails = configuredStylingDetails(styleable)
        if stylingDetails.lastParent !== styleable.skt_parent {
            stylingDetails.lastParent = styleable.skt_parent
        }
        
        let applications = collectStyleApplications(styleable, includeChildren: includeChildren)
        
        style(applications, animated: animated)
    }
    
    public func applyIfScheduled(styleable: Styleable) {
        let stylingDetails = configuredStylingDetails(styleable)
        // If parent is scheduled, we don't want to trigger the child
        if stylingDetails.parentItemStylingDetails?.stylingScheduled ?? false {
            return
        }
        
        if let scheduledStyling = stylingDetails.scheduledStyleApplication {
            apply(styleable, includeChildren: scheduledStyling.includeChildren, animated: scheduledStyling.animated)
        }
    }
    
    public func scheduleStyleApplication(styleable: Styleable, includeChildren: Bool = true, animated: Bool) {
        let stylingDetails = configuredStylingDetails(styleable)
        let cancellable = cancellableDispatchAsync {
            self.apply(styleable, includeChildren: includeChildren, animated: animated)
        }
        
        let scheduled = ScheduledStyling(includeChildren: includeChildren, animated: animated, cancellable: cancellable)
        stylingDetails.scheduledStyleApplication = scheduled
    }
    
    public func scheduleStyleApplicationIfNeeded(styleable: Styleable, includeChildren: Bool = true, animated: Bool) {
        let stylingDetails = configuredStylingDetails(styleable)
        if !stylingDetails.stylingScheduled {
            scheduleStyleApplication(styleable, includeChildren: includeChildren, animated: animated)
        }
    }
    
    public func clearCaches(keepCapacity: Bool = false) {
        canonicalTypesCache.removeAll(keepCapacity: keepCapacity)
    }
    
    func style(applications: [StyleApplication], animated: Bool) {
        // Default implementation does not support animations
        applications.forEach { application in
            guard let details = application.owner, styleable = details.styledItem else { return }
            details.scheduledStyleApplication?.cancel()
            details.scheduledStyleApplication = nil
            if application.styles.isEmpty { return }
            
            details.beingStyled = true
            
            details.beforeStyled?(styleable)
            
            for style in application.styles {
                style.styling(styleable)
            }
            
            details.afterStyled?(styleable)
            
            details.beingStyled = false
        }
    }
    
    func appendStyle(target: StyleTarget, inside: [StyleTarget], styling: Styleable -> ()) {
        if !canonicalTypes.contains({ $0 == target.type }) {
            canonicalTypes.append(target.type)
        }
        
        let identifier = ObjectIdentifier(target.type)
        let style = Style(index: index, inside: inside, target: target, styling: styling)
        if !styles.keys.contains(identifier) {
            styles[identifier] = (canonicalType: target.type, styles: [])
        }
        styles[identifier]?.styles.append(style)
        
        index += 1
    }
    
    func styledItem(item: Styleable) -> StyledItem {
        let canonical = canonicalTypeOf(item.dynamicType)
        return StyledItem(canonicalType: canonical, styleable: item)
    }
    
    private func canonicalTypeOf(type: Styleable.Type) -> Styleable.Type {
        let cacheKey = ObjectIdentifier(type)
        if let cachedType = canonicalTypesCache[cacheKey] {
            return cachedType.canonicalType
        } else {
            let determinedType = determineCanonicalTypeOf(type)
            canonicalTypesCache[cacheKey] = (type: type, canonicalType: determinedType)
            return determinedType
        }
        
    }
    
    private func determineCanonicalTypeOf(type: Styleable.Type) -> Styleable.Type {
        var currentType: AnyClass? = type
        while let unwrappedType = currentType where !canonicalTypes.contains({ $0 == unwrappedType }) {
            currentType = unwrappedType.superclass()
        }
        return currentType as? Styleable.Type ?? type
    }
    
    private func collectStyleApplications(styleable: Styleable, includeChildren: Bool) -> [StyleApplication] {
        let stylingDetails = configuredStylingDetails(styleable)
        let application: StyleApplication
        if let cachedApplication = stylingDetails.cachedStyleApplication {
            application = cachedApplication
        } else {
            let stylesToApply = matchingStyles(styleable)
            application = StyleApplication(owner: stylingDetails, styles: stylesToApply)
            stylingDetails.cachedStyleApplication = application
        }
        
        if includeChildren {
            return [application] + styleable.skt_children.flatMap {
                self.collectStyleApplications($0, includeChildren: includeChildren)
            }
        } else {
            return [application]
        }
    }
    
    private func matchingStyles(styleable: Styleable) -> [Style] {
        let item = styledItem(styleable)
        let identifier = ObjectIdentifier(item.canonicalType)
        
        guard let typeStyles = styles[identifier] else { return [] }
        
        return typeStyles.styles.map { (precedence: $0.precedence(self, item: item), style: $0) }
            .filter { $0.precedence != Style.nonMatchingPrecedence }
            .sort { $0.precedence < $1.precedence }
            .map { $0.style }
    }
    
    private func configuredStylingDetails(styleable: Styleable) -> StylingDetails {
        let stylingDetails = styleable.skt_stylingDetails
        if stylingDetails.manager == nil {
            stylingDetails.manager = self
        }
        return stylingDetails
    }
}


/// MARK: - Singleton instance management
extension StyleManager {
    /**
     Gets or creates a new instance of StyleManager.
     
     The new instance will be created dynamically using the designated initializer. This is a way to have sort of
     injected instance. When you call this on `UIKitStyleManager`, the instance will be of type `UIKitStyleManager`.
     Alternatively you can also use `StyleManager.setInstance()`
     
     - SeeAlso: `StyleManager.setInstance(newInstance: StyleManager)`
     */
    public class var instance: StyleManager {
        if let instance = currentInstanceOrNil {
            return instance
        } else {
            let instance: StyleManager = self.init()
            currentInstanceOrNil = instance
            return instance
        }
    }
    
    class func destroyInstance() {
        currentInstanceOrNil = nil
    }
    
    class func setInstance(newInstance: StyleManager) {
        currentInstanceOrNil = newInstance
    }
}

// MARK: - CustomStringConvertible
extension StyleManager: CustomStringConvertible {
    
    public var description: String {
        //styles: [ObjectIdentifier: [Style]] = [:]
        
        let styleDescrpitions = styles.values.flatMap { $0.styles.map { $0.description } }
        
        return "\(styleDescrpitions.count) declared styles: ---------------\n" + styleDescrpitions.joinWithSeparator("\n\n")
    }
    
}

// MARK: - CustomDebugStringConvertible
extension StyleManager: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        var output = [description]
        
        let canonicalTypesDescription = (
            ["\(canonicalTypes.count) canonical types: ---------------"] + canonicalTypes.map { "  \($0)" }.sort()
        ).joinWithSeparator("\n")
        
        let canonicalTypesCacheDescription = (
            ["\(canonicalTypesCache.count) cached canonical types (type = canonical type): ---------------"] +
            canonicalTypesCache.values.map { "  \($0.type) = \($0.canonicalType)" }.sort()
        ).joinWithSeparator("\n")
        
        output.append(canonicalTypesDescription)
        
        output.append(canonicalTypesCacheDescription)

        return output.joinWithSeparator("\n\n")
    }
    
}