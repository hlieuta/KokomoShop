//
//  CategoryRoute.swift
//  KokomoShop
//
//  Created by Huy Ta on 2/5/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import OperaSwift

extension Route {

    enum Category: RouteType {
        
        case getCategory(categoryId: String)
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .
            getCategory:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .getCategory(let categoryId):
                if Constants.Category.topCategoryId == categoryId {
                    return "wcs/resources/store/10251/categoryview/@top"
                }else {
                    return "wcs/resources/store/10251/categoryview/byParentCategory/\(categoryId)"
                }
            }
        }
        
    }
}
