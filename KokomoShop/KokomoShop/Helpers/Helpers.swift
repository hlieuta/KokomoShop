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

func getImages(url: String, completionHandler: @escaping ([String]) -> Swift.Void) -> Void {
    var urls = [String]()
    urls.append(url)
    let index = url.index(url.startIndex, offsetBy: url.characters.count - 5)
    let baseUrl = url.substring(to: index)
    for i in 2 ... 5 {
        let checkingUrl = "\(baseUrl)\(i).jpg"
        let imageUrl = URL(string:checkingUrl)
        if(remoteFileExists(url: imageUrl!)){
            urls.append(checkingUrl)
        }else{
            completionHandler(urls)
            return
        }
    }
   completionHandler(urls)
}

func remoteFileExists(url: URL) -> Bool {
    var exists: Bool = false
    var request = URLRequest(url: url)
    request.httpMethod = "HEAD"
    let session = URLSession.shared
    let semaphore = DispatchSemaphore(value: 0)
    session.dataTask(with: request) {data, response, err in
        if let httpResponse = response as? HTTPURLResponse {
            exists = httpResponse.statusCode == 200
        }
        semaphore.signal()
    }.resume()
    _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    return exists
}
