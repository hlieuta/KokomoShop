//
//  ProductModal.swift
//  KokomoShop
//
//  Created by Huy Ta on 6/30/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import Foundation
import Decodable
import RealmSwift
import Opera

final class Product: Object {
    
    dynamic var storeID: String?
    dynamic var name: String?
    dynamic var uniqueID: String?
    dynamic var partNumber: String?
    dynamic var fullImage: String?
    dynamic var thumbnail: String?
    dynamic var buyable: String?
    dynamic var longDescription: String?
    dynamic var shortDescription: String?

    
    /**
     Return property names that should be ignored by Realm. Realm will not persist these properties.
     */
    override static func ignoredProperties() -> [String] {
        return []
    }
    convenience init(storeID: String?,
                     name: String?,
                     uniqueID: String?,
                     partNumber: String?,
                     fullImage: String?,
                     thumbnail: String?,
                     buyable: String?,
                     longDescription: String?,
                     shortDescription: String?) {
        self.init()
        self.storeID = storeID
        self.name = name
        self.uniqueID = uniqueID
        self.partNumber = partNumber
        self.fullImage = fullImage
        self.thumbnail = thumbnail
        self.buyable = buyable
        self.longDescription = longDescription
        self.shortDescription = shortDescription
        
        
    }
}

extension Product: Decodable, OperaDecodable {
    
    static func decode(_ data: Any) throws -> Product {
        return try Product(storeID: data => "storeID",
                           name: data =>? "name",
                           uniqueID: data =>? "uniqueID",
                           partNumber: data =>? "partNumber",
                           fullImage: data =>? "fullImage",
                           thumbnail: data =>? "thumbnail",
                           buyable: data =>? "buyable",
                           longDescription: data =>? "longDescription",
                           shortDescription: data =>? "shortDescription")
    }
    
}
