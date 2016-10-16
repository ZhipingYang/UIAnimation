//
//  PhotoPresentAnimator.swift
//  AnimationTutorial
//
//  Created by Daniel on 16/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class PhotoPresentAnimator: NSObject {

}


extension PhotoPresentAnimator : UIViewControllerAnimatedTransitioning {
    
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
        toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        let screenBounds = UIScreen.main.bounds

        let oriImageFrame = CGRect.init(x: 100, y: 164, width: 200, height: 100)
        let movingImage =  UIImageView.init(frame: oriImageFrame);
        movingImage.image = UIImage.init(named: "17.jpg")
        containerView.addSubview(movingImage)
        
        UIView.animate(withDuration: duration, animations: { 
            movingImage.frame = CGRect.init(x: 0, y: (screenBounds.height-400)/2.0, width: screenBounds.width, height: 400)
            }) { (finished) in
                toVC.view.isHidden = false
                movingImage.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
