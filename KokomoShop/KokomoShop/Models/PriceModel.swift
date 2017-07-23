//
//  PriceModel.swift
//  KokomoShop
//
//  Created by Huy Ta on 7/20/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import Foundation
import Decodable
import RealmSwift
import OperaSwift

final class Price: Object {
    
    dynamic var priceDescription: String?
    dynamic var priceUsage: String?
    dynamic var priceValue: String?
    
    /**
     Return property names that should be ignored by Realm. Realm will not persist these properties.
     */
    override static func ignoredProperties() -> [String] {
        return []
    }
    convenience init(priceDescription: String?, priceUsage: String?, priceValue: String?) {
        self.init()
        self.priceDescription = priceDescription
        self.priceUsage = priceUsage
        self.priceValue = priceValue
    }
}

extension Price: Decodable, OperaDecodable {
    
    static func decode(_ data: Any) throws -> Price {
        return try Price(priceDescription: data => "priceDescription",
                            priceUsage: data =>? "priceUsage",
                            priceValue: data =>? "priceValue")
    }
    
}
