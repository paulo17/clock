//
//  Redirect.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit

func redirect(from current: UIViewController, to: UIViewController) {
    to.modalTransitionStyle = .CrossDissolve
    current.presentViewController(to, animated: true, completion: nil)
}
