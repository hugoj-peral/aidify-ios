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
    var realname: String?
    var avatar: String?
    var location: String
    var beaconId: String?
    
    init(userID: Int, username: String, company: String) {
        self.userID = userID
        self.username = username
        self.company = company
        self.location = UserLocation.Working.rawValue
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userID, forKey: "userID")
        aCoder.encodeObject(username, forKey: "username")
        aCoder.encodeObject(company, forKey: "company")
        aCoder.encodeObject(realname, forKey: "realname")
        aCoder.encodeObject(avatar, forKey: "avatar")
        aCoder.encodeObject(location, forKey: "location")
        aCoder.encodeObject(beaconId, forKey: "beaconId")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.userID = aDecoder.decodeObjectForKey("userID") as! Int
        self.username = aDecoder.decodeObjectForKey("username") as! String
        self.company = aDecoder.decodeObjectForKey("company") as! String
        self.realname = aDecoder.decodeObjectForKey("realname") as? String
        self.avatar = aDecoder.decodeObjectForKey("avatar") as? String
        self.location = aDecoder.decodeObjectForKey("location") as! String
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
    
    func convertToUserData() -> UserData? {
        guard let avatar = avatar, userLocation = UserLocation(rawValue: location) else {
            return nil
        }
        return UserData(userID: userID, name: username, realName: realname, location:userLocation, avatar:avatar, stats:UserStats(reputation:0, impact:0, helpful:0, buggy:0, total:0), activities:[])
    }
}
