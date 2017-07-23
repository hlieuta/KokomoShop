//
//  ProductCollectionViewCell.swift
//  KokomoShop
//
//  Created by Huy Ta on 7/20/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import UIKit
import RxSwift

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    
    private (set) var rx_reusableDisposeBag = DisposeBag()
    override func prepareForReuse() {
        rx_reusableDisposeBag = DisposeBag()
        super.prepareForReuse()
    }
}
