//
//  BaseViewController.swift
//  ChatApp
//
//  Created by CebuSQA on 14/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
    
    var navBarHeight: CGFloat?
    
    lazy var userTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "Username"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 2250/255, alpha: 1.0)
        textField.setLeftPaddingPoints(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
       // textField.delegate = self
        return textField
    }()
    
    lazy var userInputErrorLabel: UILabel = {
        let label = UILabel()
       // label.backgroundColor = .blue
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "password"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 2250/255, alpha: 1.0)
        //textField.background = UIImage(named: "textfield_bg")?.withRenderingMode(.alwaysTemplate)
        textField.setLeftPaddingPoints(10)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
  //      textField.delegate = self
        return textField
    }()
    
    lazy var passwordInputErrorLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .blue
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var signupLoginBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setBackgroundImage(UIImage(named: "green_btn_light"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var signuploginLink: UILabel = {
      //  let button = UIButton(type: UIButtonType.custom)
      //  let title: NSAttributedString = NSAttributedString(string: "Login")
      //  button.setAttributedTitle(title, for: .normal)
        let label = UILabel()
        label.textAlignment = .center
    
        label.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(presentLoginVC), for: .touchUpInside)
        return label
    }()
    
    let underLine: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
        navBarHeight = navigationController?.navigationBar.frame.height

        view.addSubview(userTextField)
        view.addSubview(userInputErrorLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordInputErrorLabel)
        view.addSubview(signupLoginBtn)
        view.addSubview(signuploginLink)
        view.addSubview(underLine)
        view.addSubview(userAgreementLabel)
        setUserTextField()
        setupUserInputErrorLabel()
        setPasswordTextField()
        setupPassInputErrorLabel()
        setupSignupBtn()
        setupLoginLink()
        setUndeline()
        setupUserAgreementLabel1()

    }
   
    
    func setUserTextField() {
        //need x, y, width, height
        let width: CGFloat = view.bounds.width * (603 / 640)
        let constraints: [NSLayoutConstraint] = [userTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                 userTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 30 + navBarHeight! + UIApplication.shared.statusBarFrame.height), //158 * (568 / 1136) + UIApplication.shared.statusBarFrame.height
                                                 userTextField.widthAnchor.constraint(equalToConstant: width),
                                                 userTextField.heightAnchor.constraint(equalToConstant: 40)]//79 *  (568 / 1136))]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupUserInputErrorLabel() {
        let constraints: [NSLayoutConstraint] = [userInputErrorLabel.leftAnchor.constraint(equalTo: userTextField.leftAnchor),
                                                 userInputErrorLabel.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 5),
                                                 userInputErrorLabel.widthAnchor.constraint(equalTo: userTextField.widthAnchor)]
//                                                 userInputErrorLabel.heightAnchor.constraint(equalToConstant: 20)]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setPasswordTextField() {
        
        let constraints: [NSLayoutConstraint] = [passwordTextField.leftAnchor.constraint(equalTo: userTextField.leftAnchor),
                                                 passwordTextField.topAnchor.constraint(equalTo: userInputErrorLabel.bottomAnchor, constant: 15),
                                                 passwordTextField.widthAnchor.constraint(equalTo: userTextField.widthAnchor),
                                                 passwordTextField.heightAnchor.constraint(equalTo: userTextField.heightAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupPassInputErrorLabel() {
        let constraint: [NSLayoutConstraint] = [passwordInputErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
                                                passwordInputErrorLabel.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
                                                passwordInputErrorLabel.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
                                                passwordInputErrorLabel.heightAnchor.constraint(equalTo: userInputErrorLabel.heightAnchor)]
        NSLayoutConstraint.activate(constraint)
    }
    
    func setupSignupBtn() {

        let constraints: [NSLayoutConstraint] = [signupLoginBtn.topAnchor.constraint(equalTo: passwordInputErrorLabel.bottomAnchor, constant: 15),
                                                 signupLoginBtn.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
                                                 signupLoginBtn.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupLoginLink() {
        let constraints: [NSLayoutConstraint] = [signuploginLink.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                 signuploginLink.topAnchor.constraint(equalTo: signupLoginBtn.bottomAnchor, constant: 20 * (568 / 1136))]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setUndeline(){
        let constraints: [NSLayoutConstraint] = [underLine.topAnchor.constraint(equalTo: signuploginLink.bottomAnchor, constant: -1),
                                                 underLine.widthAnchor.constraint(equalTo: signuploginLink.widthAnchor),
                                                 underLine.leftAnchor.constraint(equalTo: signuploginLink.leftAnchor),
                                                 underLine.heightAnchor.constraint(equalToConstant: 1)]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupUserAgreementLabel1(){
        let constraints: [NSLayoutConstraint] = [userAgreementLabel.topAnchor.constraint(equalTo: underLine.bottomAnchor, constant: 20),
                                                 userAgreementLabel.widthAnchor.constraint(equalTo: userTextField.widthAnchor),
                                                 userAgreementLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupUserAgreementLabel() {
        userAgreementLabel.anchor(top: signuploginLink.bottomAnchor,
                                  leading: nil,
                                  bottom: nil,
                                  trailing: nil,
                                  centerX: view.centerXAnchor,
                                  centerY: nil,
                                  padding: UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0),
                                  size: CGSize.init(width: view.bounds.width * (603 / 640), height: 0))
    }

    
    func displayError(){
        userInputErrorLabel.text = "Value is incorrect"
        passwordInputErrorLabel.text = "Value is incorrect"
    }
    
    func verifyForm(user: String, pass: String) ->Bool{
        
        let userInputStringCount: Int = user.trimmingCharacters(in: .whitespacesAndNewlines).count
        let passwordInputStringCount: Int = user.trimmingCharacters(in: .whitespacesAndNewlines).count
        
        
        if userInputStringCount == 0 || passwordInputStringCount == 0 {
            print("error")
            displayError()
            return false
        }
        
        if (userInputStringCount < 8 || userInputStringCount > 16) ||
            (passwordInputStringCount < 8 || passwordInputStringCount > 16) {
            print("error")
            displayError()
            return false
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
