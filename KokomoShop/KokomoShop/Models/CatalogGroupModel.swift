//
//  CatalogGroupModel.swift
//  KokomoShop
//
//  Created by Huy Ta on 2/5/17.
//  Copyright © 2017 'Kokomo'. All rights reserved.
//

import Foundation
import Decodable
import RealmSwift
import OperaSwift

final class CatalogGroup: Object {
    
    dynamic var recordSetTotal: String?
    dynamic var resourceName: String?
    dynamic var recordSetComplete: String?
    dynamic var recordSetStartNumber: String?
    let  CatalogGroupView = List<Category>()
    /**
     Return property names that should be ignored by Realm. Realm will not persist these properties.
     */
    override static func ignoredProperties() -> [String] {
        return []
    }
    convenience init(recordSetTotal: String?, resourceName: String?, recordSetComplete: String?,recordSetStartNumber: String?, CatalogGroupView: [Category]? ) {
        self.init()
        self.recordSetTotal = recordSetTotal
        self.resourceName = resourceName
        self.recordSetComplete = recordSetComplete
        self.recordSetStartNumber = recordSetStartNumber
        if let catalogGroup = CatalogGroupView {
            self.CatalogGroupView.append(objectsIn:catalogGroup)
        }
    }
}

extension CatalogGroup: Decodable, OperaDecodable {
    
    static func decode(_ data: Any) throws -> CatalogGroup {
        return try CatalogGroup(recordSetTotal: data => "recordSetTotal",
                                resourceName: data =>? "resourceName",
                                recordSetComplete: data =>? "recordSetComplete",
                                recordSetStartNumber: data =>? "recordSetStartNumber",
                                CatalogGroupView: data =>? "CatalogGroupView")
    }
    
}
