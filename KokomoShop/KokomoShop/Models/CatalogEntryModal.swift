//
//  CatalogEntryModal.swift
//  KokomoShop
//
//  Created by Huy Ta on 7/1/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import Foundation
import Decodable
import RealmSwift
import OperaSwift

final class CatalogEntry: Object {
    
    dynamic var recordSetTotal: String?
    dynamic var resourceName: String?
    dynamic var recordSetComplete: String?
    dynamic var recordSetStartNumber: String?
    let  CatalogEntryView = List<Product>()
    /**
     Return property names that should be ignored by Realm. Realm will not persist these properties.
     */
    override static func ignoredProperties() -> [String] {
        return []
    }
    convenience init(recordSetTotal: String?, resourceName: String?, recordSetComplete: String?,recordSetStartNumber: String?, CatalogEntryView: [Product]? ) {
        self.init()
        self.recordSetTotal = recordSetTotal
        self.resourceName = resourceName
        self.recordSetComplete = recordSetComplete
        self.recordSetStartNumber = recordSetStartNumber
        if let catalogEntry = CatalogEntryView {
            self.CatalogEntryView.append(objectsIn:catalogEntry)
        }
    }
}

extension CatalogEntry: Decodable, OperaDecodable {
    
    static func decode(_ data: Any) throws -> CatalogEntry {
        return try CatalogEntry(recordSetTotal: data => "recordSetTotal",
                                resourceName: data =>? "resourceName",
                                recordSetComplete: data =>? "recordSetComplete",
                                recordSetStartNumber: data =>? "recordSetStartNumber",
                                CatalogEntryView: data =>? "CatalogEntryView")
    }
    
}
