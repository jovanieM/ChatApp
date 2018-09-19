//
//  Extension.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

// MARK: - UITextField
extension UITextField {
    func setLeftPaddingPoints (_ value: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

// MARK: - UIColor
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

// MARK: - UIView
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
    
}
