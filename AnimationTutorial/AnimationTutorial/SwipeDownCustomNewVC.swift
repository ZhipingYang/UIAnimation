//
//  SwipeDownCustomNewVC.swift
//  AnimationTutorial
//
//  Created by Daniel on 15/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class SwipeDownCustomNewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Next VC"
        
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(self.buttonClick(_:)))
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        print("button click")
    }
}
