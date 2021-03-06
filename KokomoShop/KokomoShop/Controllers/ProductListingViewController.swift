//
//  ProductListingViewController.swift
//  KokomoShop
//
//  Created by Huy Ta on 6/27/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import UIKit

class ProductListingViewController: UIViewController {

    var productPages = [ProductViewController] ()
    
    fileprivate struct Storyboard{
        
        static let ShopPagerTabStripSegueIdentifier = "productBarPagerTabStrip"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == Storyboard.ShopPagerTabStripSegueIdentifier{
            let shopButtonBarPager =  segue.destination as! ShopButtonBarPagerTabStripViewController
            shopButtonBarPager.productPages = self.productPages
        }
        

    }
 

}


