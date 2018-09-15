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
        button.addTarget(self, action: #selector(presentSignupVC), for: .touchUpInside)
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
        
        print("signupbuttonFrame \(signupBtn.frame)")
        print("signupbuttonFrame \(signupBtn.bounds)")
        
        
        // Do any additional setup after loading the view.
    }

    func setupAppLogo(){
        //need x, y, width, height
        let _width: CGFloat = view.bounds.width * ( 246 / 640)
        
        appLogo.anchor(top: view.topAnchor,
                       leading: nil,
                       bottom: nil,
                       trailing: nil,
                       centerX: view.centerXAnchor,
                       centerY: nil,
                       padding: .init(top: 276 * (568 / 1136), left: 0, bottom: 0, right: 0),
                       size: CGSize.init(width: _width, height: 0))
    
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
    
    @objc func presentSignupVC(){
        let signupVC = SignupViewController()
        let mainNav = self.navigationController as! MainNavigationController
        mainNav.pushViewController(signupVC, animated: true)
    }
    
    @objc func presentLoginVC(){
        let loginVC = LoginViewController()
        let mainNav = self.navigationController as! MainNavigationController
        mainNav.pushViewController(loginVC, animated: true)
        
    }
    
    deinit {
        print("de init is called")
    }
    
}

