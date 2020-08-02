//
//  CustomTransitionAnimator.swift
//
//  Created by Kirill Chistyakov on 30.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

class CustomTransitionAnimator: NSObject, UICollectionViewCellAnimatedTransitioning {
        
    func transitionDuration(transitionContext: UICollectionViewCellContextTransitioning) -> TimeInterval {
        return 0.15
    }
    
    func animateTransition(transitionContext: UICollectionViewCellContextTransitioning) {
        
        let toState = transitionContext.stateFor(key: .to)
        let animationDuration = transitionContext.animationDuration()
        guard let cell = transitionContext.cell() as? CustomCollectionViewCell else { return }
        
        UIView.animate(withDuration: animationDuration) {
            
            switch toState {
                
            case .drag:
                cell.alpha = 0.7
                cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                cell.stackIndicatorWidthConstraint.constant = 0.0
                cell.stackIndicatorHeightConstraint.constant = 0.0
                cell.nameLabel.alpha = 1.0
                
            case .stackBase:
                cell.alpha = 1.0
                cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                cell.stackIndicatorWidthConstraint.constant = -cell.thumbnailView.bounds.width * 0.12
                cell.stackIndicatorHeightConstraint.constant = -cell.thumbnailView.bounds.height * 0.12
                cell.nameLabel.alpha = 0.0
                
            case .stackDrag:
                cell.alpha = 0.5
                cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                cell.stackIndicatorWidthConstraint.constant = 0.0
                cell.stackIndicatorHeightConstraint.constant = 0.0
                cell.nameLabel.alpha = 0.0
                
            default:
                cell.alpha = 1.0
                cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                cell.stackIndicatorWidthConstraint.constant = 0.0
                cell.stackIndicatorHeightConstraint.constant = 0.0
                cell.nameLabel.alpha = 1.0
            }
            
            cell.layoutIfNeeded()
        }
        
    }
    
}
