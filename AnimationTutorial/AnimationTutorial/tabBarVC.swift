//
//  tabBarVC.swift
//  AnimationTutorial
//
//  Created by Daniel on 16/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

private let mainSize = UIScreen.main.bounds

class tabBarVC: UITabBarController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var dragView: UIView = {
        let dragView = UIView(frame:CGRect.init(x: 0, y: mainSize.height-49*2, width: mainSize.width, height: 49))//(x: 0, y: mainSize.height-49*2, width: mainSize.width, height: 49))
        dragView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        return dragView
    }()
    
    var playView: UIView = {
        let playView = UIView(frame:CGRect.init(x: 0, y: mainSize.height-49, width: mainSize.width, height: mainSize.height))
        playView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        return playView
    }()
    
    
    
    var animator: UIDynamicAnimator!
    var attach: UIAttachmentBehavior!
    var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(dragView);
        view.addSubview(playView);
        
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(tabBarVC.panEvent(_:)))
        dragView.addGestureRecognizer(pan)
        
        
        animator = UIDynamicAnimator.init(referenceView: view);
        
        snap = UISnapBehavior.init(item: dragView, snapTo: CGPoint.init(x: mainSize.width/2.0, y: 300))
        snap.damping = 0.55
        animator.addBehavior(snap!)
        
        attach = UIAttachmentBehavior.init(item: playView, attachedTo: dragView)
        attach.length = 0
        attach.damping = 1
        attach.frequency = 3
        animator.addBehavior(attach!)
        
        let gravity = UIGravityBehavior.init(items: [dragView,playView])
        gravity.magnitude = 100;
        animator.addBehavior(gravity)

        
    }
    
    func panEvent(_ pan: UIPanGestureRecognizer) {
        
        
        let point = pan.location(in: self.view)
        
        switch pan.state {
            
        case .began: break
            
        case .changed:
            self.snap.snapPoint.y = point.y
            
        case .ended: break
            
        case .cancelled:
            print("")
            
            
        default:
            print("")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
