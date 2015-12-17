//
//  Checkin.swift
//  clock
//
//  Created by Paul on 17/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import Parse

class Checkin: ParseModelProcotol {
    
    static var parseClassName = "Checkin"
    
    var PFobject: PFObject?
    
    let coordonate: (lat: Double, long: Double)
    let status: Bool
    
    init(coordonate: (lat: Double, long: Double), status: Bool) {
        self.coordonate = coordonate
        self.status = status
    }

}
