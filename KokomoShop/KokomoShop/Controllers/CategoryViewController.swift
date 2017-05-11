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
    
    var categoryId:String = Constants.Category.topCategoryId {
        didSet {
            loadCategory(categoryId: categoryId)
        }
        
    }
    
    
    let disposeBag = DisposeBag()
    
    fileprivate func loadCategory(categoryId: String){
        
        if(categoryId == Constants.Category.topCategoryId){
            LoadingIndicator.show()
        }
        Route.Category.getCategory(categoryId: categoryId).rx_object().subscribe(
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
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if categoryId == Constants.Category.topCategoryId {
            self.navigationItem.title = "Choose category"
        }
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
    
    fileprivate struct Storyboard{
        static let categoryCellIdentifier = "Category"
        static let subcategorySegueIdentifier = "subcategory"
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.categoryCellIdentifier, for: indexPath)
        let category = categories[indexPath.section][indexPath.row]
        if let categoryName = category.name {
            cell.textLabel?.text = categoryName
        }
        
        return cell
    }
    

   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.subcategorySegueIdentifier {
            let subcategoryController =  segue.destination as! CategoryViewController
            subcategoryController.categories.removeAll()
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedCategory = categories[indexPath.section][indexPath.row]
                if let  selectedId = selectedCategory.uniqueID {
                    subcategoryController.categoryId = selectedId
                    subcategoryController.navigationItem.title = ""
                    self.navigationItem.title = selectedCategory.name
                }

            }
        }
    }
    

}
