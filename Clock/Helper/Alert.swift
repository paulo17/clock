//
//  Alert.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit

func alertDefault(currentView: UIViewController, message: String, action: String = "Annuler") {
    
    let alertController = UIAlertController(title: "Erreur", message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alertController.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Default, handler: nil))
    currentView.presentViewController(alertController, animated: true, completion: nil)
    
}
