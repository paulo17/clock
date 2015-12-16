//
//  EventSynchroniser.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class EventSynchroniser {
    
    static func saveObject(event: Event) -> PFObject {
        
        let PFEvent = PFObject(className: Event.parseClassName)
        
        PFEvent["name"] = event.name
        PFEvent["date"] = event.date
        PFEvent["address"] = event.address
        PFEvent["lat"] = event.lat
        PFEvent["long"] = event.long
        PFEvent["user"] = PFUser.currentUser()
        
        PFEvent.saveInBackground()
        
        return PFEvent
    }
    
    static func getObject() -> PFObject? {
        return PFObject()
    }
    
    static func updateObject() -> PFObject? {
        return PFObject()
    }
    
    static func deleteObject() {
        
    }
    
    static func getUserEvent(completionHandler: (events: [Event]?, error: NSError?) -> ()) {
        
        if let user = PFUser.currentUser() {
            
            let query = PFQuery(className: Event.parseClassName)
            query.whereKey("user", equalTo: user)
            
            query.findObjectsInBackgroundWithBlock({ (PFObjects, error) -> Void in
                if error == nil {
                    if let objects = PFObjects {
                        
                        var events: [Event] = [Event]()
                        
                        for object in objects {
                            
                            var loose = ""
                            if let l = object["loose"] {
                                loose = l as! String
                            }
                            
                            let event = Event(name: object["name"] as! String, date: object["date"] as! NSDate, address: object["address"] as! String, lat: object["lat"] as! Double, long: object["long"] as! Double, loose: loose)
                            event.PFobject = object
                            events.append(event)
    
                        }
                        
                        completionHandler(events: events, error: nil)
                    }
                }
                
                completionHandler(events: nil, error: error)
            })
            
        }
    }
    
    
}