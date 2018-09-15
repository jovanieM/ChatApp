//
//  LoginViewController.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chat app"
        
        view.backgroundColor = .white

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        
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
