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
import RxCocoa
import OperaSwift


class ProductViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!

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
 
        rx.sentMessage(#selector(ProductViewController.viewWillAppear(_:)))
            .map { _ in false }
            .bind(to: viewModel.refreshTrigger)
            .addDisposableTo(disposeBag)
        
        tableView.rx.reachedBottom
            .bind(to: viewModel.loadNextPageTrigger)
            .addDisposableTo(disposeBag)
        
        viewModel.loading
            .drive(activityIndicatorView.rx.isAnimating)
            .addDisposableTo(disposeBag)
        
        Driver.combineLatest(viewModel.elements.asDriver(), viewModel.firstPageLoading) { elements, loading in return loading ? [] : elements }
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { _, product, cell in
                cell.textLabel?.text = product.name
            }
            .addDisposableTo(disposeBag)

        
    }
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
   
}
extension PaginationRequest: PaginationRequestTypeSettings{
    public var queryParameterName: String{
        return "pageSize"
    }
    public var pageParameterName: String {
        return "pageNumber"
    }
    public var firstPageParameterValue: String {
        return "1"
    }
    
}
