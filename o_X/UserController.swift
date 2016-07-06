//
//  UserController.swift
//  o_X
//
//  Created by Enrique Pajuelo on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit
import Alamofire

class UserController: WebService {
    static var sharedInstance = UserController()
    
    var currentUser: User?
    private var userList: [User] = []
    
    func register(email:String, password:String, onCompletion: (User?,String?) -> Void) {
        
        let user = ["email":email,"password":password]
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode == 200)   {
                let user = User(email: json["data"]["email"].stringValue,password:"not_given_and_not_stored", client:json["data"]["client"].stringValue, token:json["data"]["token"].stringValue)
                
                self.currentUser = user
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(email, forKey: "currentUserEmail")
                defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
                onCompletion(user,nil)
            } else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(nil,errorMessage)
            }
        })
        
        
//        OLD CODE
//        if password.characters.count < 6 {
//            onCompletion(nil, "Your password must be at least 6 characters long.")
//            return
//        }
//            
//        for user in userList {
//            if user.email == email {
//                onCompletion(nil, "User already exists.")
//                return
//            }
//        }
//        
//        currentUser = User(email: email, password: password)
//        userList.append(currentUser!)
//        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setObject(email, forKey: "currentUserEmail")
//        defaults.setObject(password, forKey: "currentUserPassword")
//        defaults.synchronize()
//        
//        onCompletion(currentUser, nil)
    }
    
    func login(email: String, password: String, onCompletion:(User?,String?) -> Void) {
        
        let user = ["email":email,"password":password]
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth/sign_in"), method: "POST", parameters: user)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode == 200)   {
                let user = User(email: json["data"]["email"].stringValue,password:"not_given_and_not_stored", client:json["data"]["client"].stringValue, token:json["data"]["token"].stringValue)
                
                self.currentUser = user
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(email, forKey: "currentUserEmail")
                defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
                onCompletion(user,nil)
            } else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(nil,errorMessage)
            }
        })
        
//        for user in userList {
//            if user.email == email && user.password == password {
//                currentUser = user
//                onCompletion(user, nil)
//                return
//            }
//        }
//        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setObject(email, forKey: "currentUserEmail")
//        defaults.setObject(password, forKey: "currentUserPassword")
//        defaults.synchronize()
//        
//        onCompletion(nil, "Your email or password is incorrect.")
    }

    func logout(onCompletion:(String?) -> Void) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("currentUserEmail")
        defaults.removeObjectForKey("currentUserPassword")
        defaults.synchronize()
        onCompletion(nil)
    }
    
}

