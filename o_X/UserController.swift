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
        //remember a request has 4 things:
        //1: A endpoint
        //2: A method
        //3: input data (optional)
        //4: A response
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
        //execute request is a function we are able to call in UserController, because UserController extends WebService (See top of file, where UserController is defined)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            //Here is our completion closure for the web request. when the web service is done, this is what is executed.
            //Not only is the code in this block executed, but we are given 2 input parameters, responseCode and json.
            //responseCode is the response code from the server.
            //json is the response data received
            print(json)
            var user:User = User(email:email,password: password, client: "", token: "")
            user.email = email
            user.password = "not_saved"
            
            
            if (responseCode == 200)   {
                //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
                //successfully registered user. get the obtained data from the json response data and create the user object to give back to the calling ViewController
                
                let t = json["data"]["email"].stringValue
                user = User(email: json["data"]["email"].stringValue,password:"not_given_and_not_stored", client:json["data"]["client"].stringValue, token:json["data"]["token"].stringValue)
                
                //and while we still at it, lets set the user as logged in. This is good programming as we are keeping all the user management inside the UserController and handling it at the right time
                self.currentUser = user
                //Note that our registerUser function has 4 parameters: email, password, presentingViewController and requestCompletionFunction
                //requestCompletionFunction is a closure for what is to happen in the ViewController when we are done with the webservice.
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the
                onCompletion(user,nil)
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                //execute the closure in the ViewController
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
        
        for user in userList {
            if user.email == email && user.password == password {
                currentUser = user
                onCompletion(user, nil)
                return
            }
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(email, forKey: "currentUserEmail")
        defaults.setObject(password, forKey: "currentUserPassword")
        defaults.synchronize()
        
        onCompletion(nil, "Your email or password is incorrect.")
    }

    func logout(onCompletion:(String?) -> Void) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("currentUserEmail")
        defaults.removeObjectForKey("currentUserPassword")
        defaults.synchronize()
    }
    
}

