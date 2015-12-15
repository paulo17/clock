//
//  EventViewController.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

class EventViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addEvent(sender: AnyObject) {
        
        let event = Event(name: nameTextField.text!, date: datePicker.date, address: placeTextField.text!, lat: 0.0, long: 0.0)
        EventSynchroniser.saveObject(event)
        
    }
}
