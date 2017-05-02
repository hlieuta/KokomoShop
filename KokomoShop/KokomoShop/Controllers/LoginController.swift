//
//  MainViewController.swift
//  KokomoShop
//
//  Created by Huy TA ( https://www.kokomo.com )
//  Copyright © 2016 Kokomo. All rights reserved.
//

import UIKit
import RxSwift
import XLSwiftKit
import Eureka
import Opera

class LoginController: FormViewController {

    fileprivate struct RowTags {
        static let LogInUsername = "log in username"
        static let LogInPassword = "log in password"
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSections()
    }

    fileprivate func setUpSections() {
        form +++ Section(header: "Advanced usage", footer: "Please enter your credentials for advanced usage")
                <<< NameRow(RowTags.LogInUsername) {
                    $0.title = "Username:"
                    $0.placeholder = "insert username here.."
                }
                <<< PasswordRow(RowTags.LogInPassword) {
                    $0.title = "Password:"
                    $0.placeholder = "insert password here.."
                }
                <<< ButtonRow() {
                    $0.title = "Log in"
                    }
                    .onCellSelection { [weak self] _, _ in
                        self?.loginTapped()
                    }
    }
    
    fileprivate func getTextFromRow(_ tag: String) -> String? {
        let textRow: NameRow = form.rowBy(tag: tag)!
        let textEntered = textRow.cell.textField.text
        return textEntered
    }
    
    fileprivate func getPasswordFromRow(_ tag: String) -> String? {
        let textRow: PasswordRow = form.rowBy(tag: tag)!
        let textEntered = textRow.cell.textField.text
        return textEntered
    }
    
    // MARK: - Actions
    
    func loginTapped() {
        
        Route.Category.top().rx_object().subscribe(onNext: { [weak self] (catalogGroup: CatalogGroup) in
            LoadingIndicator.hide()
            self?.showError("Great", message: "You have been successfully logged in")
        }).addDisposableTo(disposeBag)
        
        
    }
}
