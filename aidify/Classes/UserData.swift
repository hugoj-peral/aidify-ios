//
//  UserData.swift
//  aidify
//
//  Created by salazar on 4/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

enum UserLocation:String {
    case Working = "working"
    case Out = "out"
}

struct UserData {
    let userID: Int
    let name: String
    let realName: String?
    let location: UserLocation
    let avatar: String
    let stats: UserStats
    let activities: [UserActivity]
}

extension UserData: JSONDecodable {
    init?(dictionary: JSONDictionary) {
        /*
        guard let userID = dictionary["id"] as? Int, name = dictionary["name"] as? String, avatar = dictionary["avatar"] as? String else {
            return nil
        
        self.userID = userID
        self.name = name
        self.location = .Working
        self.avatar = avatar
        self.activities = []
        self.stats = UserStats(reputation: 0, impact: 0, helpful: 0, buggy: 0, total: 0)
        }*/
        
        guard let userID = dictionary["id"] as? Int, name = dictionary["name"] as? String, locationRawValue = dictionary["location"] as? String, avatar = dictionary["avatar"] as? String, activities = dictionary["activities"] as? [JSONDictionary], stats = dictionary["stats"] as? JSONDictionary, location = UserLocation(rawValue: locationRawValue) else {
            return nil
        }
        
        self.userID = userID
        self.name = name
        self.realName = dictionary["realName"] as? String
        self.location = location
        self.avatar = avatar
        self.activities = decode(activities) ?? []
        self.stats = decode(stats)!
        //!!!!!!!
    }
}