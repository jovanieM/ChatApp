//
//  Extension.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBar(){
        let statusBarHeight : CGFloat = UIApplication.shared.statusBarFrame.height
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.width, height: 44))
        navBar.barTintColor = .white
        let navItem = UINavigationItem(title: "Chat app")
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
}
