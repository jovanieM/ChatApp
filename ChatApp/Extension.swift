//
//  Extension.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit


extension UITextField {
    func setLeftPaddingPoints (_ value: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

extension UIColor {
    class var appColorDarkGray: UIColor {
        return UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
    }
    
    class var appColorLightGray: UIColor {
        return UIColor(red: 100/255, green: 119/255, blue: 135/255, alpha: 1.0)
    }
    
    class var appColorAliceBlue: UIColor {
        return UIColor(red: 245/255, green: 248/255, blue: 250/255, alpha: 1.0)
    }
    
    class var appColorLightGreen: UIColor {
        return UIColor(red: 136/255, green: 227/255, blue: 6/255, alpha: 1.0)
    }
    
    class var appColorDarkGreen: UIColor {
        return UIColor(red: 98/255, green: 163/255, blue: 4/255, alpha: 1.0)
    }
    
    class var appColorTitleGray: UIColor {
        return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    }
    
    class var appColorLineGray: UIColor {
        return UIColor(red: 204/255, green: 214/255, blue: 250/255, alpha: 1.0)
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
