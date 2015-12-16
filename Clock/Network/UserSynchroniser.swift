//
//  UserSynchroniser.swift
//  clock
//
//  Created by Paul on 16/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class UserSynchroniser {
    
    static func getUserByName(username: String, completionHandler: (users: [PFUser]?, error: NSError?) -> ()) {
        
        if let query = PFUser.query() {
            query.whereKey("username", containsString: username)
            
            
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
    
}
