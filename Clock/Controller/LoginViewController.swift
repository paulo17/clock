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
    
    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loginUser(email: String, password: String) {
        let query = PFUser.query()
        query!.whereKey("email", equalTo: email)
        
        query!.getFirstObjectInBackgroundWithBlock {
            (entity, error) -> Void in
            
            if error != nil || entity == nil {
                
            } else {
                PFUser.logInWithUsernameInBackground(entity!["username"] as! String, password: password, block: {
                    (PFUser, error) -> Void in
                    if let user = PFUser {
                        self.user = user
                    }
                })
            }
            
        }
    }
    
    @IBAction func callLoginUser(sender: UIButton) {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
                loginUser(email, password: password)
        }
    }
    
    @IBAction func backAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
