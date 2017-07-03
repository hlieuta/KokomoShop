//
//  CategoryModel.swift
//  KokomoShop
//
//  Created by Huy Ta on 2/5/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import Foundation
import Decodable
import RealmSwift
import OperaSwift

final class Category: Object {
    
    dynamic var identifier: String?
    dynamic var name: String?
    dynamic var uniqueID: String?
    
    /**
     Return property names that should be ignored by Realm. Realm will not persist these properties.
     */
    override static func ignoredProperties() -> [String] {
        return []
    }
    convenience init(identifier: String?, name: String?, uniqueID: String?) {
        self.init()
        self.identifier = identifier
        self.name = name
        self.uniqueID = uniqueID
    }
}

extension Category: Decodable, OperaDecodable {
    
    static func decode(_ data: Any) throws -> Category {
        return try Category(identifier: data => "identifier",
                            name: data =>? "name",
                            uniqueID: data =>? "uniqueID")
    }
    
}
