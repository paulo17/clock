//
//  EventSynchroniser.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class EventSynchroniser {
    
    static func saveObject(event: Event) {
        
        let PFEvent = PFObject(className: Event.parseClassName)
        
        PFEvent["name"] = event.name
        PFEvent["date"] = event.date
        PFEvent["address"] = event.address
        PFEvent["lat"] = event.lat
        PFEvent["long"] = event.long
        PFEvent["user"] = PFUser.currentUser()
        
        PFEvent.saveInBackground()
    }
    
    static func getObject() -> PFObject? {
        return PFObject()
    }
    
    static func updateObject() -> PFObject? {
        return PFObject()
    }
    
    static func deleteObject() {
        
    }
    
    static func getUserEvent() -> [Event]? {
        
        var events: [Event] = [Event]()
        
        if let user = PFUser.currentUser() {
            
            let query = PFQuery(className: Event.parseClassName)
            query.whereKey("user", equalTo: user)
            
            query.findObjectsInBackgroundWithBlock({ (PFObjects, error) -> Void in
                if error == nil {
                    if let objects = PFObjects {
                        for object in objects {
                            
                            let event = Event(name: object["name"] as! String, date: object["date"] as! NSDate, address: object["address"] as! String, lat: object["lat"] as! Float, long: object["long"] as! Float)
                            events.append(event)
                            
                        }
                    }
                }
            })
            
        }
        
        return events
    }
    
    
}