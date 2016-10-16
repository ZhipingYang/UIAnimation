//
//  SwipeDownCustomVC.swift
//  AnimationTutorial
//
//  Created by Daniel on 12/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//
import UIKit

class SwipeDownCustomVC: UIViewController {
    
    @IBAction func dismissAction(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(self.dismissAction(_:)))
    }

}
