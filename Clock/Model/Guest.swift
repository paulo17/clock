//
//  Guest.swift
//  clock
//
//  Created by Paul on 16/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class Guest: ParseModelProcotol {
    
    static var parseClassName = "Guest"
    
    let event: Event
    let user: PFUser
    
    init(event: Event, user: PFUser) {
        self.event = event
        self.user = user
    }
    
    static func instanciateGuests(event: Event, users: [PFUser]) -> [Guest] {
        var guests = [Guest]()
        
        for user in users {
            guests.append(Guest(event: event, user: user))
        }
        
        return guests
    }
    
    func modelToPFObject() -> PFObject {
        return PFObject(className: Guest.parseClassName)
    }

}
