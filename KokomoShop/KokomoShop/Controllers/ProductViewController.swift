//
//  ProductViewController.swift
//  KokomoShop
//
//  Created by Huy Ta on 5/18/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import OperaSwift
import RxSwift
import RxCocoa


class ProductViewController: UIViewController, IndicatorInfoProvider {
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    var itemInfo: IndicatorInfo = "View"
    var categoryId: String = ""
    
    init(categoryId:String, title:String) {
        self.categoryId = categoryId
        self.itemInfo = IndicatorInfo(title: title)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let disposeBag = DisposeBag()

    
    lazy var viewModel: PaginationViewModel<PaginationRequest<Product>> = { [unowned self] in
        return PaginationViewModel(paginationRequest: PaginationRequest(route: Route.Product.findProductsByCategory(categoryId: self.categoryId) ,query: "20", collectionKeyPath: "CatalogEntryView"))
    }()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
   
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath)
        // Configure the cell
        return cell
    }
}

