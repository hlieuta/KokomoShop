//
//  NSDate.swift
//  KokomoShop
//
//  Created by Huy TA ( https://www.kokomo.com )
//  Copyright (c) 2016 Kokomo. All rights reserved.
//

import Foundation

extension Date {

    func dblog() -> String {
        return Constants.Formatters.debugConsoleDateFormatter.string(from: self)
    }

}
