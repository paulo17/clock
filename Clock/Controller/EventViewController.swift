//
//  EventViewController.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse
import GoogleMaps

class EventViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var placeButton: UIButton!
    
    var address: String!
    var coordonate: (lat: Double, long: Double)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        placeButton.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true;
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    // Mark: - Action methods
    
    @IBAction func autocompleteClicked(sender: AnyObject) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        self.presentViewController(autocompleteController, animated: true, completion: nil)
    }
    
    // MARK: - Segue handling
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let segueIdentifier = segue.identifier {
            if segueIdentifier == "inviteFriend" {
                let eventFriendViewController = segue.destinationViewController as! EventFriendViewController
                eventFriendViewController.name = nameTextField.text!
                eventFriendViewController.date = datePicker.date
                eventFriendViewController.address = address
                eventFriendViewController.coordonate = coordonate
            }
        }
        
    }
}

extension EventViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(viewController: GMSAutocompleteViewController!, didAutocompleteWithPlace place: GMSPlace!) {
        placeButton.setTitle(place.formattedAddress, forState: .Normal)
        address = place.formattedAddress
        coordonate = (place.coordinate.latitude, place.coordinate.longitude)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func viewController(viewController: GMSAutocompleteViewController!, didFailAutocompleteWithError error: NSError!) {
        print("Error: ", error.description)
    }
    
    // User canceled the operation.
    func wasCancelled(viewController: GMSAutocompleteViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
