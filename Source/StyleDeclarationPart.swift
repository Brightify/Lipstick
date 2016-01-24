//
//  StyleDeclarationPart.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 08/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

indirect enum StyleDeclarationPart {
    case Initial(manager: StyleManager)
    case Parent(previous: StyleDeclarationPart, parent: StyleTarget)
    case Base(previous: StyleDeclarationPart)
    case Join(previous: StyleDeclarationPart, target: StyleTarget)
    
    func collapse(var blueprint: StyleBlueprint) {
        switch self {
        case .Initial(let manager):
            blueprint.chains.values.forEach { style, parents in
                manager.appendStyle(style, inside: blueprint.commonParents + parents, styling: blueprint.styling)
            }
        case .Parent(let previous, let parent):
            blueprint.addParent(parent)
            previous.collapse(blueprint)
        case .Base(let previous):
            blueprint.currentTarget = .All
            previous.collapse(blueprint)
        case .Join(let previous, let target):
            blueprint.currentTarget = .Single(target)
            previous.collapse(blueprint)
        }
    }
    
    func collapse<T: Styleable, S: SequenceType
        where S.Generator.Element == String>(type: T.Type, names: S, styling: T -> ())
    {
        let target = StyleTarget(type: type, names: Set(names))
        let typeErasedStyling = Style.typeEraseStylingFunction(styling)
        let blueprint = StyleBlueprint(firstTarget: target, styling: typeErasedStyling)
        
        collapse(blueprint)
    }
}