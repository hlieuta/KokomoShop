//
//  XLTableViewController.swift
//  KokomoShop
//
//  Created by Huy TA ( https://www.kokomo.com )
//  Copyright © 2016 Kokomo. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class XLTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var disposeBag = DisposeBag()
}
