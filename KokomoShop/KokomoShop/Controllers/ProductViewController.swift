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
import Nuke

class ProductViewController: UIViewController, IndicatorInfoProvider {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let refreshControl = UIRefreshControl()
    var disposeBag = DisposeBag()

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
    

    
    lazy var viewModel: PaginationViewModel<PaginationRequest<Product>> = { [unowned self] in
        return PaginationViewModel(paginationRequest: PaginationRequest(route: Route.Product.findProductsByCategory(categoryId: self.categoryId) ,query: "20", collectionKeyPath: "CatalogEntryView"))
    }()
    
    fileprivate lazy var emptyStateLabel: UILabel = {
        let emptyStateLabel = UILabel()
        emptyStateLabel.text = "No products found"
        emptyStateLabel.textAlignment = .center
        return emptyStateLabel
    }()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundView = emptyStateLabel
        collectionView.addSubview(self.refreshControl)
        let refreshControl = self.refreshControl
        rx.sentMessage(#selector(ProductViewController.viewWillAppear(_:)))
            .map { _ in false }
            .bind(to: viewModel.refreshTrigger)
            .addDisposableTo(disposeBag)
        
        collectionView.rx.reachedBottom
            .bind(to: viewModel.loadNextPageTrigger)
            .addDisposableTo(disposeBag)
        
        Driver.combineLatest(viewModel.elements.asDriver(), viewModel.firstPageLoading) { elements, loading in return loading ? [] : elements }
            .asDriver()
            .drive(collectionView.rx.items(cellIdentifier: "cell")) { _, product, cell in
                let productCell = cell as! ProductCollectionViewCell
                productCell.productName.text = product.name
                productCell.productDescription.text = product.shortDescription
                productCell.price.text = "$100"
                productCell.imageView.image = nil
                Nuke.loadImage(with: URL(string: Constants.Network.baseUrl.absoluteString + product.fullImage!)!, into: productCell.imageView)
                
            }
            .addDisposableTo(disposeBag)
        
        refreshControl.rx.valueChanged
            .filter { refreshControl.isRefreshing }
            .map { true }
            .bind(to: viewModel.refreshTrigger)
            .addDisposableTo(disposeBag)
        
        viewModel.loading
            .filter { !$0 && refreshControl.isRefreshing }
            .drive(onNext: { _ in refreshControl.endRefreshing() })
            .addDisposableTo(disposeBag)
        
        viewModel.emptyState
            .drive(onNext: { [weak self] emptyState in self?.emptyStateLabel.isHidden = !emptyState })
            .addDisposableTo(disposeBag)
        
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

