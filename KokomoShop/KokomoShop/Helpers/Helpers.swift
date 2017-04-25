//
//  Helpers.swift
//  KokomoShop
//
//  Created by Huy TA ( https://www.kokomo.com )
//  Copyright © 2016 'Kokomo'. All rights reserved.
//

import Foundation
import XLSwiftKit

func DEBUGLog(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
    #if DEBUG
        let fileURL = NSURL(fileURLWithPath: file)
        let fileName = fileURL.deletingPathExtension?.lastPathComponent ?? ""
        print("\(Date().dblog()) \(fileName)::\(function)[L:\(line)] \(message)")
    #endif
    // Nothing to do if not debugging
}

func DEBUGJson(_ value: AnyObject) {
    #if DEBUG
        if Constants.Debug.jsonResponse {
//            print(JSONStringify(value))
        }
    #endif
}
