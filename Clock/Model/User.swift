//
//  User.swift
//  clock
//
//  Created by Paul on 14/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class User: ParseModelProcotol {
    
    static var parseClassName = "User"
    
    var PFobject: PFObject?
    
    let username: String
    let email: String
    let firstname: String?
    let lastname: String?
    
    init(object: PFObject, username: String, email: String, firstname: String, lastname: String) {
        self.PFobject = object
        self.username = username
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
    }
    
}
