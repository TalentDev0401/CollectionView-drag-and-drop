//
//  UICollectionView+Extensions.swift
//
//  Created by Kirill Chistyakov on 29.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public var stackedDelegate: StackedCollectionViewDelegate? {
        set {
            guard let layout = collectionViewLayout as? StackedFlowLayout else { return }
            layout.delegate = newValue
        }
        get {
            return (collectionViewLayout as? StackedFlowLayout)?.delegate
        }
    }
    
    public var stackedDataSource: StackedCollectionViewDataSource? {
        set {
            guard let layout = collectionViewLayout as? StackedFlowLayout else { return }
            layout.dataSource = newValue
        }
        get {
            return (collectionViewLayout as? StackedFlowLayout)?.dataSource
        }
    }
}
