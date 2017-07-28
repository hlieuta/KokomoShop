//
//  Helpers.swift
//  KokomoShop
//
//  Created by Huy TA ( https://www.kokomo.com )
//  Copyright © 2016 'Kokomo'. All rights reserved.
//

import Foundation
import XLSwiftKit
import RxSwift

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

func getImages(url: String)-> Observable<String>  {
    return Observable.create { observer in
        observer.onNext(url)
        let index = url.index(url.startIndex, offsetBy: url.characters.count - 5)
        let baseUrl = url.substring(to: index)
        for i in 2 ... 5 {
            let checkingUrl = "\(baseUrl)\(i).jpg"
            let imageUrl = URL(string:checkingUrl)
            remoteFileExists(url: imageUrl!, done: { (available) in
                if available {
                    observer.onNext(checkingUrl)
                }
                else{
                    observer.onCompleted()
                }
            })
        }
        observer.onCompleted()
        return Disposables.create()
    }
}

func remoteFileExists(url: URL, done: @escaping (Bool) -> Void) {
    var request = URLRequest(url: url)
    request.httpMethod = "HEAD"
    let session = URLSession.shared
    session.dataTask(with: request) {data, response, err in
        if let httpResponse = response as? HTTPURLResponse {
            done(httpResponse.statusCode == 200)
        }
    }.resume()
}
