//
//  PersentAnimator.swift
//  AnimationTutorial
//
//  Created by Daniel on 15/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class PersentAnimator: NSObject {
    
}

extension PersentAnimator : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toVC.view)
        containerView.insertSubview(fromVC.view, belowSubview: toVC.view)
        
        let duration = transitionDuration(using: transitionContext)
        
        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        toVC.view.frame = finalFrame

        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                
                toVC.view.frame = screenBounds
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 3/4, animations: {
                    fromVC.view.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1)
                })
            },
            completion: { _ in
                fromVC.view.layer.transform = CATransform3DMakeScale(1, 1, 1)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
