//
//  Redirect.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit

/**
 Redirect by changing present view controller
 
 - parameter current:  UIViewControlelr
 - parameter to:      UIViewController
 */
func redirect(from current: UIViewController, to: UIViewController) {
    to.modalTransitionStyle = .CrossDissolve
    current.presentViewController(to, animated: true, completion: nil)
}
