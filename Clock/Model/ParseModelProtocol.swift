//
//  AbstractModel.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//


import Parse

protocol ParseModelProcotol {
    
    static var parseClassName: String { get }
    
    func modelToPFObject() -> PFObject

}
