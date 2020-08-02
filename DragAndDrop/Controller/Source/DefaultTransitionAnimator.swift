//
//  DefaultTransitionAnimator.swift
//
//  Created by Kirill Chistyakov on 30.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

public class DefaultTransitionAnimator: NSObject, UICollectionViewCellAnimatedTransitioning {
    
    public func transitionDuration(transitionContext: UICollectionViewCellContextTransitioning) -> TimeInterval {
        return 0.15
    }
    
    public func animateTransition(transitionContext: UICollectionViewCellContextTransitioning) {
        
        let toState = transitionContext.stateFor(key: .to)
        let cell = transitionContext.cell()
        let animationDuration = transitionContext.animationDuration()
        
        UIView.animate(withDuration: animationDuration) {
            
            switch toState {
                
            case .drag:
                cell.alpha = 0.7
                cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                
            default:
                cell.alpha = 1.0
                cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    
}
