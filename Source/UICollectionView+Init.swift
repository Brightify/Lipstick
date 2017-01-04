//
//  UICollectionView+Init.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 31/03/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public convenience init(collectionViewLayout layout: UICollectionViewLayout) {
        self.init(frame: CGRect.zero, collectionViewLayout: layout)
    }
}
