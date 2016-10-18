//
//  UICollectionView+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Lipstick

class UICollectionViewInitTest: XCTestCase {
    
    func testInit() {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(collectionViewLayout: layout)
        
        XCTAssertEqual(CGRect.zero, view.frame)
        XCTAssertEqual(layout, view.collectionViewLayout)
    }
}
