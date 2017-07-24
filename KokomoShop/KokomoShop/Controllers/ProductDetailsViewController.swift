//
//  ProductDetailsViewController.swift
//  KokomoShop
//
//  Created by Huy Ta on 7/20/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import UIKit
import XLPagerTabStrip


class ProductDetailsViewController: BarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        barView.selectedBar.backgroundColor = .orange
        barView.backgroundColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
               
        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child1 = ImagePagerViewController(itemInfo: "View 1")
        let child2 = ImagePagerViewController(itemInfo: "View 2")
        return [child1,child2]
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var product = Product (){
        didSet{
            print(product)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
