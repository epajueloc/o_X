//
//  UserController.swift
//  o_X
//
//  Created by Enrique Pajuelo on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class UserController: NSObject {
    static var sharedInstance = UserController()
    
    var currentUser: User?
    private var userList: [User] = []
    
    func register(email:String, password:String, onCompletion: (User?,String?) -> Void) {
        
        if password.characters.count < 6 {
            onCompletion(nil, "Your password must be at least 6 characters long.")
            return
        }
            
        for user in userList {
            if user.email == email {
                onCompletion(nil, "User already exists.")
                return
            }
        }
        
        currentUser = User(email: email, password: password)
        userList.append(currentUser!)
        onCompletion(currentUser, nil)
    }
    
    func login(email: String, password: String, onCompletion:(User?,String?) -> Void) {
        
        for user in userList {
            if user.email == email && user.password == password {
                currentUser = user
                onCompletion(user, nil)
                return
            }
        }
        
        onCompletion(nil, "Your email or password is incorrect.")
    }

    func logout(onCompletion:(String?) -> Void) {
        
    }
    
}
