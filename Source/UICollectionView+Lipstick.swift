//
//  UICollectionView+Lipstick.swift
//  Lipstick
//
//  Created by Tadeas Kriz on 31/03/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

extension UICollectionView {
    public convenience init(collectionViewLayout layout: UICollectionViewLayout, styles: (UICollectionView -> Void)...) {
        self.init(frame: CGRectZero, collectionViewLayout: layout)
        
        styled(with: combine(styles))
    }
}