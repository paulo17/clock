//
//  UserSynchroniser.swift
//  clock
//
//  Created by Paul on 16/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class UserSynchroniser {
    
    /**
     Get a list of PFUser object by name
     
     - parameter username: String
     - parameter completionHandler: (users: [PFUser]?, error: NSError?) -> Void
     */
    static func getUserByName(username: String, completionHandler: (users: [PFUser]?, error: NSError?) -> Void) {
        
        if let query = PFUser.query() {
            query.whereKey("username", containsString: username.lowercaseString)
            
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if error == nil {
                    
                    if let objects = objects {
                        var users = [PFUser]()
                        
                        for object in objects {
                            users.append(object as! PFUser)
                        }
                        
                        completionHandler(users: users, error: nil)
                    }
                }
                
                completionHandler(users: nil, error: error)
            })
            
        }
        
    }
    
    /**
     Get all PFUser stored on Parse Service
     
     - parameter completionHandler: (users: [PFUser]?, error: NSError?) -> Void
     */
    static func getAllUser(completionHandler: (users: [PFUser]?, error: NSError?) -> Void) {
        
        if let query = PFUser.query() {
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if error == nil {
                    
                    if let objects = objects {
                        var users = [PFUser]()
                        
                        for object in objects {
                            users.append(object as! PFUser)
                        }
                        
                        completionHandler(users: users, error: nil)
                    }
                }
            })
        }
    }
    
}
