//
//  UICollectionViewCellAnimatedTransitioning.swift
//
//  Created by Kirill Chistyakov on 30.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

@objc public enum UICollectionViewCellState: Int {
    case unknown
    case normal
    case drag
    case stackBase
    case stackDrag
}

@objc public enum UITransitionContextCellStateKey: Int {
    case from, to
}

@objc public protocol UICollectionViewCellAnimatedTransitioning {
    func transitionDuration(transitionContext: UICollectionViewCellContextTransitioning) -> TimeInterval
    func animateTransition(transitionContext: UICollectionViewCellContextTransitioning)
}

public class UICollectionViewCellContext: UICollectionViewCellContextTransitioning {
    
    var _cell = UICollectionViewCell()
    var _stateDict: [UITransitionContextCellStateKey: UICollectionViewCellState] = [.from: .normal, .to: .normal]
    var _animationDuration: TimeInterval = 0.25
    
    public func cell() -> UICollectionViewCell {
        return _cell
    }
    
    public func stateFor(key: UITransitionContextCellStateKey) -> UICollectionViewCellState {
        return _stateDict[key] ?? .normal
    }

    public func animationDuration() -> TimeInterval {
        return _animationDuration
    }
}

@objc public protocol UICollectionViewCellContextTransitioning {
    func cell() -> UICollectionViewCell
    func stateFor(key: UITransitionContextCellStateKey) -> UICollectionViewCellState
    func animationDuration() -> TimeInterval
}
