//
//  ViewController.swift
//  AnimationTutorial
//
//  Created by Daniel on 07/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class AnimationListTableVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            CircleCountingAnimationView.showCountingAnimation {
                print("动画完成")
            }
        }
        
    }

}

