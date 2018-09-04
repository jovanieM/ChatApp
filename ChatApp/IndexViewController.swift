//
//  IndexViewController.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {

    let appLogo: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "app_logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let signupBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setBackgroundImage(UIImage(named: "green_btn_dark"), for: .normal)
        button.setTitle("Sign up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentSigninVC), for: .touchUpInside)
        return button
    }()
    
    let loginBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setBackgroundImage(UIImage(named: "green_btn_light"), for: .normal)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentLoginVC), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(appLogo)
        view.addSubview(signupBtn)
        view.addSubview(loginBtn)
        setupAppLogo()
        setupSignupBtn()
        setupLoginBtn()
        
        // Do any additional setup after loading the view.
    }

    func setupAppLogo(){
        //need x, y, width, height
        let width: CGFloat = view.bounds.width * ( 246 / 640)
        appLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 276 * (568 / 1136)).isActive = true
        appLogo.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func setupSignupBtn() {
        //need x, y, width, height
        let width: CGFloat = view.bounds.width * (603 / 640)
        signupBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupBtn.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 81 * (568 / 1136)).isActive = true // (568 / 1136) = device points to pixel ratio
        signupBtn.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setupLoginBtn(){
        //need x, y, width, height
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.topAnchor.constraint(equalTo: signupBtn.bottomAnchor, constant: 20 * (568 / 1136)).isActive = true
        loginBtn.widthAnchor.constraint(equalTo: signupBtn.widthAnchor).isActive = true
    }
    
    @objc func presentSigninVC(){
        self.present(SignInViewController(), animated: true, completion: nil)
    }
    
    @objc func presentLoginVC(){
        self.present(LoginViewController(), animated: true, completion: nil)
    }
}

