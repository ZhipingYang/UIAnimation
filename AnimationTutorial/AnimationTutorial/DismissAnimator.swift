//
//  DismissAnimator.swift
//  AnimationTutorial
//
//  Created by Daniel on 12/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class DismissAnimator : NSObject {
}

extension DismissAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)

        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        let duration = transitionDuration(using: transitionContext)
        toVC.view.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                
                fromVC.view.frame = finalFrame
                
                UIView.addKeyframe(withRelativeStartTime: 1/4, relativeDuration: 3/4, animations: {
                    toVC.view.layer.transform = CATransform3DMakeScale(1, 1, 1)
                })
            },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
