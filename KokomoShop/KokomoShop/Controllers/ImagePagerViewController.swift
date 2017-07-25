//
//  ImagePagerViewController.swift
//  KokomoShop
//
//  Created by Huy Ta on 7/24/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Nuke


class ImagePagerViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var imageView: UIImageView!
    
    var itemInfo: IndicatorInfo = "View"
    var imageUrl = ""

    init(imageUrl:String) {
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageUrl.isEmpty{
            imageView = nil
        }else{
            Nuke.loadImage(with: URL(string: imageUrl)!, into: imageView)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}
