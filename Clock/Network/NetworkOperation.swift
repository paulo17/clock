//
//  NetworkOperationProtocol.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Foundation
import Parse

protocol NetworkOperation {
    
    static func saveObject(model: ParseModelProcotol)
    
    static func getObject() -> PFObject?
    
    static func updateObject() -> PFObject?
    
    static func deleteObject() 
    
}
