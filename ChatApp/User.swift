//
//  User.swift
//  ChatApp
//
//  Created by CebuSQA on 06/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

class User: NSObject{

    var username: String?
    var password: String?
    
    init(name: String, password: String) {
        self.username = name
        self.password = password
    }
}
