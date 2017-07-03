//
//  Manager.swift
//  KokomoShop
//
//  Created by Huy TA ( https://www.kokomo.com )
//  Copyright © 2016 Kokomo. All rights reserved.
//

import Foundation
import OperaSwift
import Alamofire
import KeychainAccess
import RxSwift

class NetworkManager: RxManager {
    
    // Add a Github personal access token to have more requests per hour
    static let singleton = NetworkManager(manager: SessionManager.default)
    
    override init(manager: Alamofire.SessionManager) {
        super.init(manager: manager)
        observers = [Logger()]
    }
    
    func refreshToken() -> Observable<String?> {
        return Observable.just(nil)
    }
    
}

struct Logger: OperaSwift.ObserverType {
    func willSendRequest(_ alamoRequest: Alamofire.Request, requestConvertible: URLRequestConvertible) {
        debugPrint(alamoRequest)
    }
}

final class Route {}

