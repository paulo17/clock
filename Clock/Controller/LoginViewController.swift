//
//  LoginViewController.swift
//  clock
//
//  Created by Paul on 14/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                        if let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("homeView") {
                            redirect(from: self, to: homeViewController)
                        }
                    } else {
                        alertDefault(self, message: "Email ou mot de passe incorrect")
                    }
                    
                })
            }
            
        }
    }
    
    // MARK: - IBAction methods
    
    @IBAction func callLoginUser(sender: UIButton) {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
                loginUser(email, password: password)
        }
    }
    
    @IBAction func backAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
