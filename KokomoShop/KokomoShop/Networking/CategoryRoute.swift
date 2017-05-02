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
import Opera

extension Route {
    
    enum Category: RouteType {
        
        case top()
        case getSubCategory(categoryId: String)
    
        var method: Alamofire.HTTPMethod {
            switch self {
            case .
                top, .getSubCategory:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .top():
                return "wcs/resources/store/10251/categoryview/@top"
            case .getSubCategory(let categoryId):
                return "wcs/resources/store/10251/categoryview/byParentCategory/\(categoryId)"
            }
        }
        
    }
}
