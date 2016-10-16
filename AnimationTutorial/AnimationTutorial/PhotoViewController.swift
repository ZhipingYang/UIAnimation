//
//  PhotoViewController.swift
//  AnimationTutorial
//
//  Created by Daniel on 16/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var interactor:Interactor? = nil
    var image:UIImage? = nil
    
    var originFrame = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        // Do any additional setup after loading the view.
    }
    
    @IBAction func panDismiss(_ sender: UIPanGestureRecognizer) {
        
        let percentThreshold:CGFloat = 0.5
        
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let horizonMovement = translation.x / view.bounds.width
        let downwardMovement = fmax(Float(verticalMovement), 0.0)
        let rightMovement = fmax(Float(horizonMovement), 0.0)
        let downwardMovementPercent = fmin(downwardMovement, 1.0)
        let rightMovementPercent = fmin(rightMovement, 1.0)
        let progress = CGFloat(max(rightMovementPercent, downwardMovementPercent))
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            let point = sender.velocity(in: view)
            let maxSpped = max(point.x, point.y)
            interactor.shouldFinish = maxSpped>500 ? true : (progress > percentThreshold && maxSpped>10)
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
    

}
