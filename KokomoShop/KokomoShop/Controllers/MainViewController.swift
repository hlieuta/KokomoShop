//
//  MainViewController.swift
//  KokomoShop
//
//  Created by Huy Ta on 5/9/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    fileprivate struct Storyboard{
        static let shopTabItem = "Shop"
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewControllers()
    }
    
    fileprivate func initializeViewControllers(){
        for viewController in self.viewControllers! {
            if viewController is UINavigationController {
                let nav = viewController as! UINavigationController
               
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }


}
