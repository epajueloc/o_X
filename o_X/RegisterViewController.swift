//
//  RegisterViewController.swift
//  o_X
//
//  Created by Enrique Pajuelo on 7/1/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func registerButton(sender: AnyObject) {
        let onCompletion = { (currentUser: User?, error: String?) in
            if currentUser == nil {
                let errorMessage: String = error!
                let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) in })
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }  else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()
                let application = UIApplication.sharedApplication()
                let window = application.keyWindow
                window?.rootViewController = viewController
            }
        }
        UserController.sharedInstance.register(emailField.text!, password: passwordField.text!, onCompletion: onCompletion)
    }
}