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

class EventViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var placeButton: UIButton!
    
    var address: String!
    var coordonate: (lat: Double, long: Double)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Mark: - Action methods
    
    @IBAction func autocompleteClicked(sender: AnyObject) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        self.presentViewController(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func addEvent(sender: AnyObject) {
        
        if let address = self.address, let location = self.coordonate {
            let event = Event(name: nameTextField.text!, date: datePicker.date, address: address, lat: location.lat, long: location.long)
            EventSynchroniser.saveObject(event)
            
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
