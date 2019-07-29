//
//  RequestResponseHandler.swift
//  NewApex
//
//  Created by Hemareddy Halli on 4/14/19.
//  Copyright © 2019 Apex Capital Corp. All rights reserved.
//

import Foundation
class RequestResponseHandler : NSObject, ConnectionHandlerDelegate
{
    let dataDownloadDelegate: DataDownloadDelegate
    
    init(with delegate: DataDownloadDelegate)
    {
        self.dataDownloadDelegate = delegate
        super.init()
    }
    
    func createGETRequest(with url: String)
    {
        var urlRequest = URLRequest(url: URL(string: url)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 45 )
        urlRequest.httpMethod = kGETMethod
        let connectionHandler = ConnectionHandler(with: self as ConnectionHandlerDelegate)
        connectionHandler.processRequest(with: urlRequest)
        
    }
    
    func createPOSTRequest(with url: String, body: [String : Any]) {
        var urlRequest = URLRequest(url: URL(string: url)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 45 )
        urlRequest.httpMethod = kPOSTMethod
        do {
            let dataExample : NSData = try NSKeyedArchiver.archivedData(withRootObject: body, requiringSecureCoding: true) as NSData
            urlRequest.httpBody = dataExample as Data
            let connectionHandler = ConnectionHandler(with: self as ConnectionHandlerDelegate)
            connectionHandler.processRequest(with: urlRequest)
        } catch
        {
            print("Data decription failed")
        }

    }
    //MARK: ConnectionHandlerDelegate
    func successWithResponse(_ data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("\(json)")
            self.dataDownloadDelegate.dataToHandlerWithSuccess(with: (json as? [String : AnyObject])!)
        }
    }
    
    func falied(with error: Error, errorDictionary: [String : Any]?, status: HTTPURLResponse?) {
        self.dataDownloadDelegate.dataToHandlerWithFailure(with: error, errorDictionary:errorDictionary, status: status)
    }
}
