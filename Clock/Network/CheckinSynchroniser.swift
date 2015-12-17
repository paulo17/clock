//
//  CheckinSynchroniser.swift
//  clock
//
//  Created by Paul on 17/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class CheckinSynchroniser {
    
    /**
     Persit Checkin object in Parse Service
     
     - parameter checkin: Checkin
     - parameter event:   PFObject
     
     - returns: PFObject
     */
    static func saveObject(checkin: Checkin, event: PFObject) -> PFObject {
        
        let PFCheckin = PFObject(className: Checkin.parseClassName)
        
        PFCheckin["lat"] = checkin.coordonate.lat
        PFCheckin["long"] = checkin.coordonate.long
        PFCheckin["status"] = checkin.status
        PFCheckin["user"] = PFUser.currentUser()
        PFCheckin["event"] = event
        
        PFCheckin.saveInBackground()
        
        return PFCheckin
    }
    
    /**
     Get checkin user for event
     
     - parameter user: PFUser
     - parameter event: Event
     - parameter completionHandler: (checkin: Checkin?, error: NSError?) -> Void
     */
    static func getUserEventCheckin(user: PFUser, event: PFObject, completionHandler: (checkin: Checkin?, error: NSError?) -> Void) {
        
        let query = PFQuery(className: Checkin.parseClassName)
        query.whereKey("user", equalTo: user)
        query.whereKey("event", equalTo: event)
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if let pfcheckin = object {
                
                let checkin = Checkin(coordonate: (lat: pfcheckin["lat"] as! Double, long: pfcheckin["long"] as! Double), status: pfcheckin["status"] as! Bool)
                checkin.PFobject = object
                
                completionHandler(checkin: checkin, error: nil)
            } else {
                completionHandler(checkin: nil, error: error)
            }
        }
        
    }
}