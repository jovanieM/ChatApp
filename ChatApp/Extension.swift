//
//  Extension.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var _navigationBar: UINavigationBar {
        let statusBarHeight : CGFloat = UIApplication.shared.statusBarFrame.height
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 44))
        navBar.barTintColor = .white
        let navItem = UINavigationItem(title: "Chat app")
        navBar.setItems([navItem], animated: false)
      
        return navBar
    }
    var _bottomBar: UIView {
        let bottomBAr: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        bottomBAr.translatesAutoresizingMaskIntoConstraints = false
        let chatbox: UITextField = UITextField()
        chatbox.borderStyle = .roundedRect
        chatbox.backgroundColor = .red
        chatbox.translatesAutoresizingMaskIntoConstraints = false
        bottomBAr.addSubview(chatbox)
        chatbox.anchor(top: bottomBAr.topAnchor, leading: bottomBAr.leadingAnchor, bottom: bottomBAr.bottomAnchor, trailing: bottomBAr.trailingAnchor, centerX: bottomBAr.centerXAnchor, centerY: nil, padding: UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4))
        
        return bottomBAr
    }
    
    
    func setNavigationBar(){
        let statusBarHeight : CGFloat = UIApplication.shared.statusBarFrame.height
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 44))
        navBar.barTintColor = .white
        let navItem = UINavigationItem(title: "Chat app")
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
}

extension UITextField {
    func setLeftPaddingPoints (_ value: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

extension String {
    func getUnderlinedAttributedText() -> NSAttributedString{
        return NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
    }
}

extension UIView {
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        }
        return leadingAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        }
        return trailingAnchor
    }
    
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                centerX: NSLayoutXAxisAnchor?,
                centerY: NSLayoutYAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
