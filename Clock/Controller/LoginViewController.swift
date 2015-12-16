//
//  LoginViewController.swift
//  clock
//
//  Created by Paul on 14/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.layer.cornerRadius = 5
        
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillAppear"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide"), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Textfield Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true;
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    // MARK: - Parse methods
    
    func loginUser(email: String, password: String) {
        let query = PFUser.query()
        query!.whereKey("email", equalTo: email)
        
        query!.getFirstObjectInBackgroundWithBlock { (entity, error) -> Void in
            
            if error != nil || entity == nil {
                alertDefault(self, message: "Email incorrect")
            } else {
                PFUser.logInWithUsernameInBackground(entity!["username"] as! String, password: password, block: {
                    (PFUser, error) -> Void in
                    
                    if PFUser != nil {
                        if let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("homeViewNav") {
                            redirect(from: self, to: homeViewController)
                        }
                    } else {
                        alertDefault(self, message: "Email ou mot de passe incorrect")
                        self.passwordTextField.text = ""
                    }
                    
                })
            }
            
        }
    }

    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if emailTextField.text != "" && passwordTextField.text != "" {
            loginButton.enabled = true
            loginButton.backgroundColor = UIColorFromRGBA("FFFFFF", alpha: 1.0)
        } else {
            loginButton.enabled = false
            loginButton.backgroundColor = UIColorFromRGBA("FFFFFF", alpha: 0.5)
        }
        
        return true
    }
    
    
    // MARK: - Function
    
    func keyboardWillAppear() {
        logoTopConstraint.constant = 50.0
    }
    
    func keyboardWillHide() {
        logoTopConstraint.constant = 133
    }
    
    
    // MARK: - IBAction methods
    
    @IBAction func callLoginUser(sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
                loginUser(email, password: password)
        }
    }
    

}
