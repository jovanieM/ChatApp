//
//  IndexViewController.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {

    // MARK: - Properties
    let appLogo: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "app_logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let signupBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        let image = #imageLiteral(resourceName: "green_btn_dark").withRenderingMode(.alwaysTemplate)
        
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = UIColor.appColorDarkGreen
        button.setTitle("Sign up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentSignupVC), for: .touchUpInside)
        return button
    }()
    
    let loginBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        let image = #imageLiteral(resourceName: "green_btn_light").withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = UIColor.appColorLightGreen
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentLoginVC), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - ViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view didload called again")
        view.backgroundColor = .white
        view.addSubview(signupBtn)
        view.addSubview(appLogo)
        view.addSubview(loginBtn)
        setupSignupBtn()
        setupAppLogo()
        setupLoginBtn()
    }
    
    // MARK: - Setup UI constraints functions
    func setupSignupBtn() {
        // x, y, width, height
        let width: CGFloat = view.bounds.width * (603 / 640)
        signupBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupBtn.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true 
        signupBtn.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setupAppLogo(){
        // x, y, width, height
        let _width: CGFloat = view.bounds.width * ( 246 / 640)
        appLogo.bottomAnchor.constraint(equalTo: signupBtn.topAnchor, constant: -30).isActive = true
        appLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        appLogo.widthAnchor.constraint(equalToConstant: _width).isActive = true
 
    }
    
    func setupLoginBtn(){
        //need x, y, width, height
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.topAnchor.constraint(equalTo: signupBtn.bottomAnchor, constant: 10).isActive = true
        loginBtn.widthAnchor.constraint(equalTo: signupBtn.widthAnchor).isActive = true
    }

    // MARK: - Navigation
    @objc func presentSignupVC(){
        
        self.present(UINavigationController(rootViewController: SignupViewController()), animated: true, completion: nil)
    }
    
    @objc func presentLoginVC(){
       
        self.present(UINavigationController(rootViewController: LoginViewController()), animated: true, completion: nil)

    }
    
}

