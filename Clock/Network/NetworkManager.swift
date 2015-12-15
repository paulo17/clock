//
//  NetworkManager.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit
import Parse

class NetworkManager {
    
    static func saveEvent(event: Event) {
        let PFEvent = PFObject(className: Event.parseClassname)
        PFEvent["name"] = event.name
        PFEvent["date"] = event.date
        PFEvent["address"] = event.address
        PFEvent["lat"] = event.lat
        PFEvent["long"] = event.long
        
        do {
            try PFEvent.save()
        } catch let error {
            print(error)
        }
    }
    
    /*static func getEvent() -> Event? {
        
    }*/
}
