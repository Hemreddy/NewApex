//
//  ConnectionHandler.swift
//  NewApex
//
//  Created by Hemareddy Halli on 4/14/19.
//  Copyright © 2019 Apex Capital Corp. All rights reserved.
//

import Foundation

protocol ConnectionHandlerDelegate {
    
    func successWithResponse(_ data : Data)
    func falied(with error: Error, errorDictionary: [String : Any]?, status: HTTPURLResponse? )
}

class ConnectionHandler: NSObject, URLSessionDelegate
{
    let mSession = URLSession.shared
    var connectionHandlerDelegate: ConnectionHandlerDelegate
    init(with Delegate: ConnectionHandlerDelegate)
    {
        connectionHandlerDelegate = Delegate
        super.init()
    }
    
    func processRequest(with urlRequest: URLRequest)
    {
        let task = mSession.dataTask(with: urlRequest) { data, response, error in
            
            if let theError = error
            {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                    self.connectionHandlerDelegate.falied(with:theError, errorDictionary: json as? [String : Any] , status: response as? HTTPURLResponse )
                    return
                }

            }

            if let theData = data
            {
                self.connectionHandlerDelegate.successWithResponse(theData)
            }

        }
       task.resume()
    }
    
    func cancelRequest()
    {
        //mSession.task
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?)
    {
        if let theError = error
        {
                self.connectionHandlerDelegate.falied(with:theError, errorDictionary: nil , status: nil )
                return
        }
    }
}
