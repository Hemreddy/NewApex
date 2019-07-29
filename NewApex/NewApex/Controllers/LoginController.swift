//
//  LoginController.swift
//  NewApex
//
//  Created by Hemareddy Halli on 4/14/19.
//  Copyright © 2019 Apex Capital Corp. All rights reserved.
//

import Foundation
protocol LoginViewControllerDelegate {
    func successfulLogin(with: ApexBaseDTO)
    func loginFailed(with error: Error, errorDictionary: [String : Any]?, status: HTTPURLResponse?)
}

class LoginController : NSObject, RequestResponseDataDelegate
{
    var viewController: LoginViewControllerDelegate
    
     init(with loginController: LoginViewControllerDelegate )
     {
        self.viewController = loginController
        super.init()
     }
    
    func sendLoginRequest(with username: String, password: String)
    {
        let theLoginDict = [kUsername : username, kPassword : password ]
        let loginRequestResponseHandler = LoginRequestResponseHandler(with: self)
        
        loginRequestResponseHandler.formLoginRequestandSend(With: theLoginDict)
    }
    
    //MARK: RequestResponseDataDelegate
    func successWithResponse(inData: ApexBaseDTO)
    {
        DispatchQueue.main.async {
            self.viewController.successfulLogin(with: inData)
        }
    }
    
    func failed(with error: Error, errorDictionary: [String : Any]?, status: HTTPURLResponse?)
    {
        DispatchQueue.main.async {
            self.viewController.loginFailed(with: error, errorDictionary: errorDictionary, status: status)
        }
    }
    
}
