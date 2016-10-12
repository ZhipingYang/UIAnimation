//
//  SwipeDownViewController.swift
//  AnimationTutorial
//
//  Created by Daniel on 12/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class SwipeDownTableViewController: UITableViewController {
    
    @IBAction func dismiss(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil);
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let interactor = (navigationController as! NaviVC).interactor else { return }
        
        let percentThreshold:CGFloat = 0.3
        
        let y = scrollView.contentOffset.y
        
        if y>=0 {
            interactor.update(0)
            interactor.shouldFinish = false
            return
        }
        
        let progress = abs(y)/UIScreen.main.bounds.height

        interactor.shouldFinish = y < 0 && progress > percentThreshold
        interactor.update(progress)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let interactor = (navigationController as! NaviVC).interactor else { return }
        interactor.hasStarted = true
        dismiss(animated: true, completion: nil)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let interactor = (navigationController as! NaviVC).interactor else { return }
        
        let y = scrollView.contentOffset.y
        
        if y<0 && abs(y)/UIScreen.main.bounds.height>0.3 {
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
    
        } else {
            interactor.hasStarted = false
            interactor.cancel()
        }

    }

}
