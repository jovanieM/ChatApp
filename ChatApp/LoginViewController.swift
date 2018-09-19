//
//  LoginViewController.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LoginViewController: BaseViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
        navigationItem.title = "Chat app"
        view.backgroundColor = .white
        signupLoginBtn.setTitle("Login", for: .normal)
        signupLoginBtn.addTarget(self, action: #selector(validateLoginForm), for: .touchUpInside)
        signuploginLink.attributedText = NSAttributedString(string: "Sign up",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.appColorLightGray])
        signuploginLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushSignupVC)))
    }
    
    @objc func validateLoginForm() {
        
        if userTextField.isEditing { userTextField.resignFirstResponder() }
        if passwordTextField.isEditing { passwordTextField.resignFirstResponder() }
        let userInput = userTextField.text!
        let passwordInput = passwordTextField.text!
        
        guard verifyForm(user: userInput, pass: passwordInput) else {return}
        
        checkMembership(user: userInput, pass: passwordInput) { (isAuthorized) in
            if isAuthorized {
                self.presentChatRoomVC(user: User(username: userInput, password: ""))
            } else {
                self.displayError()
            }
        }
    }
    
    func checkMembership(user: String, pass: String, completion: @escaping (Bool) -> ()) {
    
        var isAuthorized: Bool = false
        
        let ref = Database.database().reference().child(Constants.USERS_PATH.rawValue)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                print("username is \(dictionary.debugDescription)")
                
                for userdata in dictionary.values{
                    
                    let _user = userdata[Constants.USERNAME_KEY.rawValue] as! String
                    let _pass = userdata[Constants.PASSWORD_KEY.rawValue] as! String
                                 
                    if (user == _user && pass == _pass){
                        isAuthorized = true
                        print("success")
                        break
                    }
                }
            }
            //call completion closure and set the result as parameter
            completion(isAuthorized)
            
        }) { (error) in
            
            print(error.localizedDescription)
            
        }
    }
    
    func presentChatRoomVC(user: User){

        if let vc = presentingViewController{
            self.dismiss(animated: true, completion: nil)
            let collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.minimumLineSpacing = 20
            let chatroomVC = ChatRoomViewController(collectionViewLayout: collectionViewFlowLayout)
            chatroomVC.user = user
            vc.present(UINavigationController(rootViewController: chatroomVC), animated: true, completion: nil)
        }
    }
    
    @objc func pushSignupVC() {
        if let vc = presentingViewController{
            self.dismiss(animated: true, completion: nil)
            vc.present(UINavigationController(rootViewController: SignupViewController()), animated: true, completion: nil)
        }
    }
    
    // MARK: - UITextFieldDelegate functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEditing{
            textField.endEditing(true)
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        removeError()
    }
    
    // restrict user from using special characters as username
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (userTextField.isEditing){
            let charSet = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered = string.components(separatedBy: charSet).joined(separator: "")
            return (string == filtered)
        }
        return true
    }
}
