//
//  BaseViewController.swift
//  ChatApp
//
//  Created by CebuSQA on 14/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    // MARK: - Properties
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
    
    var navBarHeight: CGFloat?

    let navigationBarSeparatorLine: UIView = {
        let separatorline = UIView()
        separatorline.backgroundColor = UIColor.appColorLineGray
        separatorline.translatesAutoresizingMaskIntoConstraints = false
        return separatorline
    }()
    
    lazy var userTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.appColorLightGray])
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.appColorAliceBlue
        textField.setLeftPaddingPoints(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        textField.attributedPlaceholder = NSAttributedString(string: "password",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.appColorLightGray])
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.appColorAliceBlue
        textField.setLeftPaddingPoints(10)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordInputErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var signupLoginBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        let image = #imageLiteral(resourceName: "green_btn_light").withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = UIColor.appColorLightGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var signuploginLink: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let underLine: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.appColorLightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userAgreementLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        let localString  = NSLocalizedString("userAgreement", comment: "")
        label.attributedText = NSAttributedString(string: localString,
                           attributes: [NSAttributedStringKey.foregroundColor: UIColor.appColorLightGray])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        view.addSubview(navigationBarSeparatorLine)
        view.addSubview(userTextField)
        view.addSubview(userInputErrorLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordInputErrorLabel)
        view.addSubview(signupLoginBtn)
        view.addSubview(signuploginLink)
        view.addSubview(underLine)
        view.addSubview(userAgreementLabel)
        setNavigationBarSeparatorLine()
        setUserTextField()
        setupUserInputErrorLabel()
        setPasswordTextField()
        setupPassInputErrorLabel()
        setupSignupBtn()
        setupLoginLink()
        setUndeline()
        setupUserAgreementLabel1()
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
    }
    
    func setNavigationBarSeparatorLine(){
        
        //constraints
        navigationBarSeparatorLine.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navigationBarSeparatorLine.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navigationBarSeparatorLine.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        navigationBarSeparatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
   
    // MARK: - SetupUI functions
    func setUserTextField() {
        //need x, y, width, height
        let width: CGFloat = view.bounds.width * (603 / 640)
        let constraints: [NSLayoutConstraint] = [userTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                 userTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 30), //158 * (568 / 1136) + UIApplication.shared.statusBarFrame.height
                                                 userTextField.widthAnchor.constraint(equalToConstant: width),
                                                 userTextField.heightAnchor.constraint(equalToConstant: 40)]//79 *  (568 / 1136))]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupUserInputErrorLabel() {
        let constraints: [NSLayoutConstraint] = [userInputErrorLabel.leftAnchor.constraint(equalTo: userTextField.leftAnchor),
                                                 userInputErrorLabel.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 5),
                                                 userInputErrorLabel.widthAnchor.constraint(equalTo: userTextField.widthAnchor)]
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

    // Displays error message when the user does not comply the required paramater
    internal func displayError(){
        userInputErrorLabel.text = "Value is incorrect"
        passwordInputErrorLabel.text = "Value is incorrect"
    }
    
    internal func removeError(){
        userInputErrorLabel.text = nil
        passwordInputErrorLabel.text = nil
    }
    
    // Verify the user inputs
    func verifyForm(user: String, pass: String) ->Bool{
        
        let userInputStringCount: Int = user.trimmingCharacters(in: .whitespacesAndNewlines).count
        let passwordInputStringCount: Int = pass.trimmingCharacters(in: .whitespacesAndNewlines).count
        
        print(userInputStringCount)
        print(passwordInputStringCount)
        if userInputStringCount == 0 || passwordInputStringCount == 0 {
            displayError()
            return false
        }
        
        if (userInputStringCount < 8 || userInputStringCount > 16) ||
            (passwordInputStringCount < 8 || passwordInputStringCount > 16) {
            displayError()
            return false
        }
        
        return true
    }


}
