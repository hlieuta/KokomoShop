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
    
    fileprivate struct Storyboard{
        static let imagePagerViewControllerIdentifier = "imagePagerViewController"
    }
    
    fileprivate var imagePagerViews = [ImagePagerViewController]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        barView.selectedBar.backgroundColor = .orange
        barView.backgroundColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
               
        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return imagePagerViews
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    var product = Product (){
        didSet{
            if let coms = product.imageUrls?.components(separatedBy: "|") {
                for url in coms {
                    imagePagerViews.append(getImageViewController(url: url))
                }
            }else {
                imagePagerViews.append(getImageViewController(url: ""))
            }
            
        }
    }
    
    func getImageViewController(url:String) -> ImagePagerViewController {
        let controller = storyboard?.instantiateViewController(withIdentifier: Storyboard.imagePagerViewControllerIdentifier) as! ImagePagerViewController
        controller.imageUrl = url
        return controller
        
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
