//
//  User.swift
//  ChatApp
//
//  Created by CebuSQA on 06/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

class User{
    
    let USER_KEY = "username"
    let PASS_KEY = "password"

    var username: String?
    var password: String?
    
    init(user: String, pass: String){
        username = user
        password = pass
    }
  
    
}
