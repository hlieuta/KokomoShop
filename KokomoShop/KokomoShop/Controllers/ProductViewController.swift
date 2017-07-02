//
//  ProductViewController.swift
//  KokomoShop
//
//  Created by Huy Ta on 5/18/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import Opera


class ProductViewController: UIViewController, IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo = "View"
    fileprivate var categoryId: String

    
    init(categoryId:String, title:String) {
        self.categoryId = categoryId
        self.itemInfo = IndicatorInfo(title: title)
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var viewModel: PaginationViewModel<PaginationRequest<CatalogEntry>> = {
        return PaginationViewModel(paginationRequest: PaginationRequest(route: Route.Product.findProductsByCategory(categoryId: self.categoryId), collectionKeyPath: "CatalogEntryView"))
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Driver.combineLatest()
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
