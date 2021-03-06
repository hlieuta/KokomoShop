//
//  RouteType.swift
//  KokomoShop
//
//  Created by Huy TA ( https://www.kokomo.com )
//  Copyright © 2016 Kokomo. All rights reserved.
//

import Foundation
import OperaSwift
import Alamofire

extension RouteType {

    var baseURL: URL { return Constants.Network.baseUrl }
    var manager: ManagerType { return NetworkManager.singleton  }
    var retryCount: Int { return 0 }
}

extension URLRequestParametersSetup {
    public func urlRequestParametersSetup(_ urlRequest: NSMutableURLRequest, parameters: [String: AnyObject]?) -> [String: AnyObject]? {
        var params = parameters ?? [:]
        if let token = SessionController.sharedInstance.token {
            params[Constants.Network.AuthTokenName] = token as AnyObject?
        }
        return params
    }
}
