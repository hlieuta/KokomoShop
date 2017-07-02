//
//  ProductRoute.swift
//  KokomoShop
//
//  Created by Huy Ta on 7/1/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import Opera

extension Route {
    
    enum Product: RouteType {
        
        case findProductsByCategory(categoryId: String)
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .
            findProductsByCategory:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .findProductsByCategory(let categoryId):
                return "wcs/resources/store/10251/productview/byCategory/\(categoryId)"
            }
        }
        
    }
}

