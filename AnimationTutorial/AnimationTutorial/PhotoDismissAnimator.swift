//
//  PhotoDismissAnimator.swift
//  AnimationTutorial
//
//  Created by Daniel on 16/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class PhotoDismissAnimator: NSObject {

}


extension PhotoDismissAnimator : UIViewControllerAnimatedTransitioning {
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
        fromVC.view.isHidden = true
        let screenBounds = UIScreen.main.bounds
        
        let duration = transitionDuration(using: transitionContext)
        
        let oriImageFrame = CGRect.init(x: 0, y: (screenBounds.height-400)/2.0, width: screenBounds.width, height: 400)
        let movingImage =  UIImageView.init(frame: oriImageFrame);
        movingImage.image = UIImage.init(named: "17.jpg")
        containerView.addSubview(movingImage)

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                movingImage.frame = CGRect(x: 100, y: 164, width: 200, height: 100)
            },
            completion: { _ in
                movingImage.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
