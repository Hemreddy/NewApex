//
//  LoginRequestResponseHandler.swift
//  NewApex
//
//  Created by Hemareddy Halli on 4/14/19.
//  Copyright © 2019 Apex Capital Corp. All rights reserved.
//

import Foundation

class LoginRequestResponseHandler: NSObject, DataDownloadDelegate
{
    var mPassword: String?
    var requestResponseDataDelegate: RequestResponseDataDelegate
    init(with delegate: RequestResponseDataDelegate)
    {
        self.requestResponseDataDelegate = delegate
        super.init()
    }
    
    func formLoginRequestandSend(With dictionary: [String : Any])
    {
        let username = dictionary[kUsername]
        self.mPassword = dictionary[kPassword] as? String
        var requestURL = kBase_URL + kLoginWebservice
        let theUsernameParm = String(format: "?\(kWebServiceUsername)=\(username!)&\(kWebServicePassword)=\(self.mPassword!)&\(kVersion)=APL-6.0.1")
        requestURL.append(theUsernameParm)
        
        let requestResponseHandler = RequestResponseHandler(with: self)
        requestResponseHandler.createGETRequest(with: requestURL)
    }
    
    //MARK: - DataDownloadDelegate
    func dataToHandlerWithSuccess(with dictionary: [String : AnyObject]) {
        let loginResponseDTO = LoginResponseDTO()
        loginResponseDTO.friendlyName = dictionary[kFriendlyName] as? String
        loginResponseDTO.userName = dictionary[kWebServiceUsername] as? String
        loginResponseDTO.sessionID = dictionary[kSessionId] as? String
        loginResponseDTO.password = self.mPassword
        loginResponseDTO.profileCount = dictionary[kProfileCount] as? NSNumber
        loginResponseDTO.profileId = dictionary[kProfileID] as? NSNumber
        loginResponseDTO.tutorialsRequired = dictionary[kTutorialAvailable] as? NSNumber
        loginResponseDTO.tutorialsCount = dictionary[kTutorialCount] as? NSNumber
        self.mPassword = nil;
        self.requestResponseDataDelegate.successWithResponse(inData: loginResponseDTO)
    }
    
    func dataToHandlerWithFailure(with error: Error,  errorDictionary: [String : Any]?, status: HTTPURLResponse?) {
         self.requestResponseDataDelegate.failed(with: error, errorDictionary: errorDictionary, status: status)
    }
    
}
