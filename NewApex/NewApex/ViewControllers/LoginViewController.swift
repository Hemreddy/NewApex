//
//  ViewController.swift
//  NewApex
//
//  Created by Hemareddy Halli on 4/14/19.
//  Copyright © 2019 Apex Capital Corp. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, LoginViewControllerDelegate {


    @IBOutlet weak var mUserName: UITextField!
    @IBOutlet weak var mPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func login(_ sender: Any) {
        
        if let theUsername = mUserName!.text, let thePassword = mPassword!.text
        {
            if !validateUsername(theUsername)
            {
                print("Invalid Username")
                return
            }
            if thePassword.count > 8
            {
                print("Invalid Password")
                return
            }
            
            let loginController = LoginController(with: self)
        loginController.sendLoginRequest(with: theUsername, password: thePassword)
            
        
        }
        print("Username is \(String(describing: mUserName!.text)) & password is \(String(describing: mPassword!.text))")
    }

    func callLoginrequest()
    {
        
    }
    
    func validateUsername(_ username: String) -> Bool
    {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testString = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return testString.evaluate(with:username)
    }
    
    //MARK: LoginViewControllerDelegate
    func successfulLogin(with inData: ApexBaseDTO) {
        let letData = inData as? LoginResponseDTO
        let alertController = UIAlertController(title: "Successful Login!", message: "username is \(letData!.userName ?? "").", preferredStyle: .alert)
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func loginFailed(with error: Error, errorDictionary: [String : Any]?, status: HTTPURLResponse?) {
        
    }
    
    
}

