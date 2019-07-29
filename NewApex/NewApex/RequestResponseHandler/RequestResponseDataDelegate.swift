//
//  RequestResponseDataDelegate.swift
//  NewApex
//
//  Created by Hemareddy Halli on 4/14/19.
//  Copyright © 2019 Apex Capital Corp. All rights reserved.
//

import Foundation

protocol RequestResponseDataDelegate {
    func successWithResponse(inData: ApexBaseDTO)
    func failed(with error: Error, errorDictionary: [String : Any]?, status: HTTPURLResponse?)
}
