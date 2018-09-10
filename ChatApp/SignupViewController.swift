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

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
    
    lazy var userTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.background = UIImage(named: "textfield_bg")
        textField.setLeftPaddingPoints(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.background = UIImage(named: "textfield_bg")
        textField.setLeftPaddingPoints(10)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    let signupBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setBackgroundImage(UIImage(named: "green_btn_light"), for: .normal)
        button.setTitle("Sign up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentChatRoomVC), for: .touchUpInside)
        return button
    }()
    
    let loginLnk: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        let title: NSAttributedString = NSAttributedString(string: "Login")
        button.setAttributedTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentLoginVC), for: .touchUpInside)
        return button
    }()
    
    let userAgreementLabel: UILabel = {
        let label: UILabel = UILabel()
        //label.backgroundColor = UIColor.lightGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        let s  = NSLocalizedString("userAgreement", comment: "")
        label.text = s
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var navBar: UINavigationBar?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    
        navBar = _navigationBar
        self.view.addSubview(navBar!)
        
        view.addSubview(userTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signupBtn)
        view.addSubview(loginLnk)
        view.addSubview(userAgreementLabel)
        setUserTextField()
        setPasswordTextField()
        setupSignupBtn()
        setupLoginLink()
        setupUserAgreementLabel()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBar?.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navBar?.isHidden = false
    }

    func setUserTextField() {
        //need x, y, width, height
        let width: CGFloat = view.bounds.width * (603 / 640)
        let constraints: [NSLayoutConstraint] = [userTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                 userTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 158 * (568 / 1136) + UIApplication.shared.statusBarFrame.height),
                                                 userTextField.widthAnchor.constraint(equalToConstant: width),
                                                 userTextField.heightAnchor.constraint(equalToConstant: 79 *  (568 / 1136))]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setPasswordTextField() {
        //need x, y, width, height
        let width: CGFloat = view.bounds.width * (603 / 640)
        let constraints: [NSLayoutConstraint] = [passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                 passwordTextField.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 40 * (568 / 1136)),
                                                 passwordTextField.widthAnchor.constraint(equalToConstant: width),
                                                 passwordTextField.heightAnchor.constraint(equalToConstant: 79 *  (568 / 1136))]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSignupBtn() {
        //need x, y, width, height
        let width: CGFloat = view.bounds.width * (603 / 640)
        let constraints: [NSLayoutConstraint] = [signupBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                 signupBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40 * (568 / 1136)), // (568 / 1136) = device points to pixel ratio
                                                 signupBtn.widthAnchor.constraint(equalToConstant: width)]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupLoginLink() {
        let constraints: [NSLayoutConstraint] = [loginLnk.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                 loginLnk.topAnchor.constraint(equalTo: signupBtn.bottomAnchor, constant: 20 * (568 / 1136))]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupUserAgreementLabel() {
        userAgreementLabel.anchor(top: loginLnk.bottomAnchor,
                                  leading: nil,
                                  bottom: nil,
                                  trailing: nil,
                                  centerX: view.centerXAnchor,
                                  centerY: nil,
                                  padding: UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0),
                                  size: CGSize.init(width: view.bounds.width * (603 / 640), height: 0))
    }
    
    @objc func presentLoginVC() {
        
        if let presentingVC = presentingViewController as? IndexViewController{
            self.dismiss(animated: true) {
                presentingVC.presentLoginVC()
            }
        }
    }
    
    @objc func presentChatRoomVC(){
        
        do {
            try signUP(username: userTextField.text!, password: passwordTextField.text!)
        } catch LoginSignUpError.IncompleteForm {
            print("1")
        } catch LoginSignUpError.IncorrectInputLength {
            print("2")
        } catch LoginSignUpError.IncorrectNameOrPassword {
            print("3")
        } catch {
            print("Unknown error")
        }
        
//        let userInputStringCount: Int = userTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).count
//        let passwordInputStringCount: Int = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).count
//        
//        if (userInputStringCount == 0 || passwordInputStringCount == 0){
//            print("return error")
//        } else if((userInputStringCount < 8 || userInputStringCount > 16) ||
//            (passwordInputStringCount < 8 || passwordInputStringCount > 16)){
//            print("min/max value violation")
//        }else{
//            print("wrong pass/user")
//        }
        
//        let values = ["username": userTextField.text!, "password": passwordTextField.text!]
//
//        let ref = Database.database().reference().child("users")
//        let childRef = ref.childByAutoId()
//        childRef.updateChildValues(values) { (err, ref) in
//            if err != nil  {
//                print("molas \(err.debugDescription)")
//            }else{
//                print("molas err \(ref.key)")
//            }
//
//        }
//        let navVC = UINavigationController(rootViewController: ChatRoomViewController(collectionViewLayout: UICollectionViewFlowLayout()))
//        present(navVC, animated: true, completion: nil)
    }
    
    func signUP(username : String, password: String) throws {
        
        
        let username: String = userTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password: String = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (username.count == 0 || password.count == 0){
            print("return error")
            throw LoginSignUpError.IncompleteForm
        }
        if((username.count < 8 || username.count > 16) || (password.count < 8 || password.count > 16)){
            print("min/max value violation")
            throw LoginSignUpError.IncorrectInputLength
        }
        
        
        if username.count == 100{
            throw LoginSignUpError.IncorrectNameOrPassword
        }
        
        signUpNewUser(withName: username) { (available) in
            if available {
                // proceed to saving user data
            } else {
                //throw error
            }
        }
       
        print("no error detected")
        
    }
    
    func signUpNewUser(withName: String, completion: @escaping(Bool) -> ()){
    
        let ref = Database.database().reference().child("users")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            var usernames: [String] = []
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print("username is \(dictionary.debugDescription)")
                
                for user in dictionary.values{
                    usernames.append((user["username"] as? String)!)
                    print("values \(user["username"])")
                }
              //  let user = dictionary.values
            }
            if usernames.contains(withName){
                completion(true)
            } else {
                completion(false)
            }
            
            print("snapshot")
        }) { (error) in
            print(error)
            
        }
        print("execution complete")
    
//        ref.(.childAdded) { (snapshot) in
//           if let dictionary = snapshot.value as? [String: AnyObject] {
//                print("username is \(dictionary.debugDescription)")
            
//                let username: String = dictionary["username"]!
//                completion(withName != username)
//            }
//        }
//        ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
//
//            if let dictionary = snapshot.value as? [String: String] {
//                print("username is \(dictionary.debugDescription)")
//
//
//            }
//        }) { (error) in
//            print("error \(error)")
//
//        }
        
        
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
    
}
