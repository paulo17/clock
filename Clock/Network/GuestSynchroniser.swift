//
//  GuestSynchroniser.swift
//  clock
//
//  Created by Paul on 16/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class GuestSynchroniser {
    
    static func saveObject(guest: Guest) {
        
        let PFGuest = PFObject(className: Guest.parseClassName)
        
        PFGuest["event"] = guest.event.modelToPFObject()
        PFGuest["user"] = guest.user
        
        PFGuest.saveInBackground()
    }
    
    static func saveObjects(guests: [Guest]) {
        for guest in guests {
            saveObject(guest)
        }
    }
}
