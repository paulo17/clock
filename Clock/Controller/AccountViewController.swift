//
//  AccountViewController.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

class AccountViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = PFUser.currentUser() {
            nameTextField.text = user.username
        }
    }
    
    @IBAction func userLogout(sender: AnyObject) {
        PFUser.logOut()
        if let loginView = self.storyboard?.instantiateViewControllerWithIdentifier("loginView") {
            loginView.modalTransitionStyle = .FlipHorizontal
            presentViewController(loginView, animated: true, completion: nil)
        }
    }
    
}
