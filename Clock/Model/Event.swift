//
//  Event.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class Event: ParseModelProcotol {
    
    static var parseClassName = "Event"
    
    var PFobject: PFObject?
    
    let name: String?
    let date: NSDate
    let address: String
    let lat: Double
    let long: Double
    let loose: String
    
    init(name: String, date: NSDate, address: String, lat: Double, long: Double, loose: String) {
        self.name = name
        self.date = date
        self.address = address
        self.lat = lat
        self.long = long
        self.loose = loose
    }
    
}
