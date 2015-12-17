//
//  GuestSynchroniser.swift
//  clock
//
//  Created by Paul on 16/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class GuestSynchroniser {
    
    /**
     Persit Guest object in Parse Service
     
     - parameter guest: Guest
     */
    static func saveObject(guest: Guest) {
        
        let PFGuest = PFObject(className: Guest.parseClassName)
        
        PFGuest["event"] = guest.event
        PFGuest["user"] = guest.user
        
        PFGuest.saveInBackground()
    }
    
    /**
     Save multiple Guest objects
     
     - parameter guests: [Guest]
     */
    static func saveObjects(guests: [Guest]) {
        for guest in guests {
            saveObject(guest)
        }
    }
    
    /**
     Get a list of guests by Event
     
     - parameter event: Event
     - parameter completionHandler: (users: [PFUser]?, error: NSError?) -> Void
     */
    static func getGuestsByEvent(event: PFObject, completionHandler: (users: [PFUser]?, error: NSError?) -> Void) {
        
        let query = PFQuery(className: Guest.parseClassName)
        query.whereKey("event", equalTo: event)
        
        query.findObjectsInBackgroundWithBlock({ (PFObjects, error) -> Void in
            if error == nil {
                if let objects = PFObjects {
                    
                    var users = [PFUser]()
                    
                    for object in objects {
                        users.append(object["user"] as! PFUser)
                    }
                    
                    completionHandler(users: users, error: nil)
                }
            }
            
            completionHandler(users: nil, error: error)
        })
        
    }
}
