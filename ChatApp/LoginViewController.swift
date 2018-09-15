//
//  LoginViewController.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LoginViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chat app"
        view.backgroundColor = .white
        signupLoginBtn.addTarget(self, action: #selector(validateLoginForm), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        
    }
    
    @objc func validateLoginForm() {
        let userInput = userTextField.text!
        let passwordInput = passwordTextField.text!
        
        guard verifyForm(user: userInput, pass: passwordInput) else {return}
        
        checkMembership(user: userInput, pass: passwordInput) { (isAuthorized) in
            if isAuthorized {
                print("autorized memmber")
            } else {
                print("unauthorized")
            }
        }
    }
    
    func checkMembership(user: String, pass: String, completion: @escaping (Bool) -> ()) {
    
        var isAuthorized: Bool = false
        
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                print("username is \(dictionary.debugDescription)")
                
                for userdata in dictionary.values{
                    
                    let _user = userdata["username"] as! String
                    let _pass = userdata["password"] as! String
                    print("username \(_user)")
                    print("username \(_pass)")
                    print("username \(user)")
                    print("username \(pass)")
                    
                    if (user == _user && pass == _pass){
                        isAuthorized = true
                        break
                    }
                }
            }
            //call completion closure and set the result as parameter
            completion(isAuthorized)
            
        }) { (error) in
            
            
            print(error.localizedDescription)
            
        }
        print("returning")
    }
    

//
//    @objc func presentSignupVC() {
//        if let presentingVC = presentingViewController as? IndexViewController {
//            self.dismiss(animated: true) {
//                presentingVC.presentSignupVC()
//            }
//        }
//    }
}
