//
//  SignInViewController.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

enum LoginSignUpError: Error{
    case IncompleteForm
    case IncorrectInputLength
    case IncorrectNameOrPassword
}

class SignupViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
        view.backgroundColor = .white
        navigationItem.title = "Chat app"
        signupLoginBtn.setTitle("Sign up", for: .normal)
        signupLoginBtn.addTarget(self, action: #selector(validateSignupForm), for: .touchUpInside)
        signuploginLink.attributedText = NSAttributedString(string: "Login",
                           attributes: [NSAttributedStringKey.foregroundColor: UIColor.appColorLightGray])
        signuploginLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushLoginVC)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Functions
    @objc func validateSignupForm() {
        userTextField.endEditing(true)
        let userInput = userTextField.text!
        let passwordInput = passwordTextField.text!
        
        guard verifyForm(user: userInput, pass: passwordInput) else {return}
        
        isUsernameAvailable(username: userInput) { (available) in
            self.signupUser(user: userInput, pass: passwordInput,completion: {
                if available{
                    print("username available")
                    
                    self.pushChatRoomVC(user: User(username: userInput, password: ""))
                } else {
                    print("username already taken")
                    self.displayError()
                }
            })
        }
        
    }
    
    // look up for matched username in database
    func isUsernameAvailable(username: String, completion: @escaping (Bool) ->())  {
        var isAvailable: Bool = true
        var usernames = [String]()
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                for user in dictionary.values{
                    
                        let _user = user["username"] as! String
                        if !usernames.contains(username){
                            usernames.append(_user)
                            print(_user)
                        } else {
                            isAvailable = false
                            break
                        }
                  
                    }
                }
            
            //call completion closure and pass result as parameter
            completion(isAvailable)
    
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func signupUser(user: String, pass: String, completion: @escaping ()->()){
       
        let ref = Database.database().reference().child("users").childByAutoId()
        
        var dictionary = [String: Any]()
        dictionary = ["username": user, "password": pass] as [String : Any]
        
        ref.updateChildValues(dictionary) { (error, ref) in
            if error != nil{
                return
            }
            completion()
        }
    }

    @objc func pushLoginVC() {

        if let vc = presentingViewController{
            self.dismiss(animated: true, completion: nil)
            
            vc.present(UINavigationController(rootViewController: LoginViewController()), animated: true, completion: nil)
        }
    }

    
    func pushChatRoomVC(user: User){
        
        if let vc = presentingViewController{
            self.dismiss(animated: true, completion: nil)
            let collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.minimumLineSpacing = 20
            let chatroomVC = ChatRoomViewController(collectionViewLayout: collectionViewFlowLayout)
            chatroomVC.user = user
            vc.present(UINavigationController(rootViewController: chatroomVC), animated: true, completion: nil)
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
    
    deinit {
        print("deinit")
    }
    
}
