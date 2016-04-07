//
//  User.swift
//  aidify
//
//  Created by Hugo Peral on 28/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    
    var userID: Int
    var username: String
    var company: String
    var beaconId: String?
    
    init(userID: Int, username: String, company: String) {
        self.userID = userID
        self.username = username
        self.company = company
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userID, forKey: "userID")
        aCoder.encodeObject(username, forKey: "username")
        aCoder.encodeObject(company, forKey: "company")
        aCoder.encodeObject(beaconId, forKey: "beaconId")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.userID = aDecoder.decodeObjectForKey("userID") as! Int
        self.username = aDecoder.decodeObjectForKey("username") as! String
        self.company = aDecoder.decodeObjectForKey("company") as! String
        self.beaconId = aDecoder.decodeObjectForKey("beaconId") as? String
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
