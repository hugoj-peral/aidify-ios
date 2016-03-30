//
//  User.swift
//  aidify
//
//  Created by Hugo Peral on 28/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    
    var username: String
    var company: String
    var beaconId: String?
    
    init(username: String, company: String) {
        self.username = username
        self.company = company
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(username, forKey: "username")
        aCoder.encodeObject(company, forKey: "company")
        if let beaconId = beaconId {
            aCoder.encodeObject(beaconId, forKey: "beaconId")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.username = aDecoder.decodeObjectForKey("username") as! String
        self.company = aDecoder.decodeObjectForKey("company") as! String
        if let beaconId = aDecoder.decodeObjectForKey("beaconId") {
            self.beaconId = beaconId as? String
        }
    }
}

extension User {
    func hasBeaconPaired() -> Bool {
        if let _ = beaconId {
            return true
        } else {
            return false
        }
        
    }
}
