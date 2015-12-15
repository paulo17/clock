//
//  RegisterViewController.swift
//  clock
//
//  Created by Paul on 14/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func registerUser() {
        let user = PFUser()
        user.username = usernameTextField.text
        user.email = emailTextField.text
        user.password = passwordTextField.text
        user["lastname"] = lastnameTextField.text
        user["firstname"] = firstnameTextField.text
        
        user.signUpInBackgroundWithBlock { (didSuccessed, error) -> Void in
            if let error = error {
                
                var message = "Erreur lors de l'inscription"
                if let e = error.userInfo["error"] {
                    message = e as! String
                }
                
                alertDefault(self, message: message)
                
            } else {
                
                // redirect to home view controller
                if let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("homeViewNav") {
                    redirect(from: self, to: homeViewController)
                }

            }
        }
    }
    
    // MARK: - IBAction methods
    
    @IBAction func callRegisterUser(sender: UIButton) {
        registerUser()
    }
    
    @IBAction func backAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
