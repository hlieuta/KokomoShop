//
//  CategoryViewController.swift
//  KokomoShop
//
//  Created by Huy Ta on 2/5/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import UIKit
import RxSwift
import Opera

class CategoryViewController: UITableViewController {
    
    
    var categories = [Array<Category>] (){
        didSet{
            tableView.reloadData()
        }
    }
    
    let disposeBag = DisposeBag()
    
    fileprivate func loadCategory(){
        LoadingIndicator.show()
        Route.Category.top().rx_object().subscribe(
            onNext: { [weak self] (catalogGroup: CatalogGroup) in
                LoadingIndicator.hide()
                self?.categories.append(Array(catalogGroup.CatalogGroupView))
            },
            onError: { (Error) in
                LoadingIndicator.hide()
        }).addDisposableTo(disposeBag)
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return categories[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showError("testing")
    }
    
    fileprivate struct Storyboard{
        static let CategoryCellIdentifier = "Category"
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CategoryCellIdentifier, for: indexPath)
        let category = categories[indexPath.section][indexPath.row]
        if let categoryName = category.name {
            cell.textLabel?.text = categoryName
        }
        
        return cell
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
