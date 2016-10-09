//
//  SlipViewController.swift
//  AnimationTutorial
//
//  Created by Daniel on 09/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class SlipViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var targetView: UIView!
    
    @IBOutlet weak var target2: UIView!
    @IBOutlet weak var target2SubView: UIView!
    
    
    
    var animation:CAKeyframeAnimation!
    var colorAnim:CAKeyframeAnimation!
    
    var groupAnim:CAAnimationGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animationTarget1()
        animationTarget2()

    }
    
    func animationTarget1() {
        targetView.layer.speed = 0.0
        
        //1
        animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 1.0
        animation.values = [
            NSValue.init(cgPoint: CGPoint.init(x: targetView.frame.midX, y: targetView.frame.midY)),
            NSValue.init(cgPoint: CGPoint.init(x: 375*1.0, y: 200)),
            NSValue.init(cgPoint: CGPoint.init(x: 375*3.0, y: 200)),
            NSValue.init(cgPoint: CGPoint.init(x: 375*3.5, y: 275))
        ]
        animation.isRemovedOnCompletion = false
        targetView.layer.add(animation, forKey: "positionAnim")
        
        //2
        colorAnim = CAKeyframeAnimation(keyPath: "backgroundColor")
        colorAnim.duration = 1.0
        colorAnim.values = [
            UIColor.white.cgColor,
            UIColor.red.cgColor,
            UIColor.blue.cgColor,
            UIColor.purple.cgColor
        ]
        colorAnim.isRemovedOnCompletion = false
        targetView.layer.add(colorAnim, forKey: "colorAnim")
    }
    
    func animationTarget2() {
        
        target2.layer.speed = 0.0

        let position = CAKeyframeAnimation(keyPath: "position")
        position.duration = 2/3.0
        position.values = [
            NSValue.init(cgPoint: CGPoint.init(x: target2.frame.midX, y: target2.frame.midY)),
            NSValue.init(cgPoint: CGPoint.init(x: 375+target2.frame.midX, y: 200)),
            NSValue.init(cgPoint: CGPoint.init(x: 375*3.5, y: 475))
        ]
        
        let trans = CABasicAnimation.init(keyPath: "transform.rotation")
        trans.toValue = -M_PI
        trans.duration = 1/3.0
        
        groupAnim = CAAnimationGroup.creatQueueGroupAnimation(arr: [trans,position])
        target2.layer.add(groupAnim, forKey: "groupAnim")
        
        //sub
        let subTrans = CABasicAnimation.init(keyPath: "transform.rotation")
        subTrans.toValue = -M_PI
        subTrans.duration = 1
        subTrans.repeatCount = MAXFLOAT
        target2SubView.layer.add(subTrans, forKey: "subTrans")
        
        //obsever
//        target2SubView.addObserver(self, forKeyPath: "transform.rotation", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath=="position" {
            target2SubView.center = target2.layer.position
        }
    }
}

extension SlipViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var x = scrollView.contentOffset.x
        x /= 375*3
        targetView.layer.timeOffset = CFTimeInterval(min(1.0, max(0.0, x)))
        target2.layer.timeOffset = CFTimeInterval(min(1.0, max(0.0, x)))
    }
    
}

extension CAAnimationGroup {
    
    class func creatQueueGroupAnimation(arr:[CAAnimation]?) -> CAAnimationGroup? {
        guard let arr = arr, !arr.isEmpty else { return nil }
        
        let group = CAAnimationGroup()
        group.animations = arr
        group.duration = arr.reduce(0, { (result:CFTimeInterval, animation) -> CFTimeInterval in
            animation.beginTime = result
            return result+animation.duration
        })
        return group
    }
}





