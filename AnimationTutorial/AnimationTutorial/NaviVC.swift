//
//  NaviVC.swift
//  AnimationTutorial
//
//  Created by Daniel on 12/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class NaviVC: UINavigationController {

    var interactor:Interactor? = nil

    override func viewDidLoad() {
        self.navigationBar.barTintColor = UIColor.purple
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white
        ]
    }
}
