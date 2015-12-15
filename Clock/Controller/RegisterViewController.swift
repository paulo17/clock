//
//  RegisterViewController.swift
//  clock
//
//  Created by Paul on 14/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = 5
        lastnameTextField.delegate = self
        firstnameTextField.delegate = self
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if lastnameTextField.text != "" && firstnameTextField.text != "" && usernameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" {
            registerButton.backgroundColor = UIColorFromRGBA("FFFFFF", alpha: 1.0)
            registerButton.enabled = true
        } else {
            registerButton.backgroundColor = UIColorFromRGBA("FFFFFF", alpha: 0.5)
            registerButton.enabled = false
        }
        
        return true
    }
    
    // MARK: - IBAction methods
    
    @IBAction func callRegisterUser(sender: UIButton) {
        registerUser()
    }
    
    @IBAction func backAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
