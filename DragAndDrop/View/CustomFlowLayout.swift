//
//  CustomFlowLayout.swift
//
//  Created by Kirill Chistyakov on 29.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

class CustomFlowLayout: StackedFlowLayout {
    
    var maxItemWidth: CGFloat = 256.0
    var labelsHeight: CGFloat = 44.0
    
    var inset: UIEdgeInsets = UIEdgeInsets(top: Constant.Margin, left: Constant.Margin, bottom: Constant.Margin, right: Constant.Margin) {
        didSet {
            setupLayout()
        }
    }
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        gestureTriggerRadius = 30.0
        minimumInteritemSpacing = Constant.Margin
        minimumLineSpacing = Constant.Margin
        scrollDirection = .vertical
        sectionInset = inset
    }

    func itemWidth() -> CGFloat {
        let viewWidth = collectionView!.frame.width
        let colCount = ceil(viewWidth / maxItemWidth)
        let totalSpacing = Constant.Margin * (colCount - 1) + inset.left + inset.right
        var itemWidth = (viewWidth - totalSpacing) / colCount
        itemWidth = roundToDecimalPlace(itemWidth, place: 2)
        return itemWidth
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemWidth() + labelsHeight)
        }
        get {
            return CGSize(width: itemWidth(), height: itemWidth() + labelsHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
    
    // Utility
    
    func roundToDecimalPlace(_ x: CGFloat, place: CGFloat) -> CGFloat {
        let multiplier = pow(10.0, place)
        return floor(multiplier * x) / multiplier
    }
}

