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
    
    
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Chat app"
        signupLoginBtn.setTitle("Sign up", for: .normal)
        signupLoginBtn.addTarget(self, action: #selector(validateSignupForm), for: .touchUpInside)
        signuploginLink.text = "Login"


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    @objc func validateSignupForm() {
        let userInput = userTextField.text!
        let passwordInput = passwordTextField.text!
        
        guard verifyForm(user: userInput, pass: passwordInput) else {return}
        
        isUsernameAvailable(username: userInput) { (available) in
            self.signupUser(user: userInput, pass: passwordInput,completion: {
                if available{
                    print("username available")
                    
                    self.presentChatRoomVC(user: User(user: userInput, pass: ""))
                } else {
                    print("username already taken")
                    self.displayError()
                }
            })
        }
        
    }
    
    
    
    func isUsernameAvailable(username: String, completion: @escaping (Bool) ->())  {
        var isAvailable: Bool = true
        var usernames = [String]()
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                print("username is \(dictionary.debugDescription)")
                
                for user in dictionary.values{
                    
                    let _user = user["username"] as! String
                    if !usernames.contains(username){
                        usernames.append(_user)
                        print(_user)
                    } else {
                        isAvailable = false
                        break
                    }
                   // usernames.append((user["username"] as? String)!)
                }
                
                }
            //call completion closure and pass result as parameter
            completion(isAvailable)
    
        }) { (error) in
            

            print(error.localizedDescription)
        
        }
        print("returning")
    
    }
    
    func signupUser(user: String, pass: String, completion: @escaping ()->()){
        print("user = \(user), pass = \(pass)")
        let ref = Database.database().reference().child("users").childByAutoId()
        
        var dictionary = [String: Any]()
        dictionary = ["username": user, "password": pass] as [String : Any]
        
        ref.updateChildValues(dictionary) { (error, ref) in
            if error != nil{
                print("update child values error \(error.debugDescription)")
                return
            }
            print("update success")
            completion()
        }
        
    }


    @objc func presentLoginVC() {
        
        if let presentingVC = presentingViewController as? IndexViewController{
            self.dismiss(animated: true) {
                presentingVC.presentLoginVC()
            }
        }
    }
    
    func presentChatRoomVC(user: User){
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 20
        let nav = self.navigationController as! MainNavigationController
        let chatView = ChatRoomViewController(collectionViewLayout: collectionViewFlowLayout)
        chatView.user = user
        nav.pushViewController(chatView, animated: true)
    }



    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEditing{
            textField.endEditing(true)
        }
        return true
    }
    
    
    
    func checkforSpecialCharacters(text: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "#[a-z0-9]+", options: .caseInsensitive)
        regex?.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
        return false
    }
    
    // text field delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if (userTextField.isEditing){
//            let charSet = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
//            let filtered = string.components(separatedBy: charSet).joined(separator: "")
//            return (string == filtered)
//        }
        return true
    }
    
    deinit {
        print("deinit")
    }
    
}
