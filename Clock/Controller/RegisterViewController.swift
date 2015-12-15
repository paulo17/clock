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
                
                let alertController = UIAlertController(title: "Erreur", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                
                // redirect to home view controller
                if let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("homeView") {
                    redirect(from: self, to: homeViewController)
                }

            }
        }
    }
    
    @IBAction func callRegisterUser(sender: UIButton) {
        registerUser()
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
