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
    let placeholderImage = UIImage(named: "ProductImagePlaceholder")
    fileprivate static let fullImage = "fs_1.jpg"
    fileprivate static let zoomImage = "zm_1.jpg"
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
    
    
    fileprivate struct Storyboard{
        static let productCellIdentifier = "cell"
        static let productDetailsSegueIdentifier = "productDetails"

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
            .drive(collectionView.rx.items(cellIdentifier: Storyboard.productCellIdentifier)) {[weak self] _, product, cell in
                let productCell = cell as! ProductCollectionViewCell
                productCell.productName.text = product.name
                productCell.productDescription.text = product.shortDescription
                productCell.price.text = "$\(product.Price[0].priceValue ?? "0.0")"
                productCell.imageView.image = self?.placeholderImage
               // Nuke.loadImage(with: URL(string: Constants.Network.baseUrl.absoluteString + product.fullImage!)!, into: productCell.imageView)
                
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
    
        collectionView.rx.modelSelected(Product.self).subscribe(onNext:  { [weak self] value in
            
            let url = "\(Constants.Network.baseUrl)\(value.fullImage?.replacingOccurrences(of: ProductViewController.fullImage, with: ProductViewController.zoomImage) ??  (String()))"
            if let string  = value.imageUrls , !string.isEmpty {
                LoadingIndicator.show()
                getImages(url: url, completionHandler: { (urls) in
                    value.imageUrls = urls.joined(separator: "|")
                    LoadingIndicator.hide()
                    self?.performSegue(withIdentifier: Storyboard.productDetailsSegueIdentifier, sender: value)
                })
            }else {
                self?.performSegue(withIdentifier: Storyboard.productDetailsSegueIdentifier, sender: value)
            }
            
            
        }).disposed(by: disposeBag)
    }
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productDetailsController = segue.destination as? ProductDetailsViewController {
            if let product = sender as? Product{
                productDetailsController.product = product
            }
        }
    }
    
    
   
}
