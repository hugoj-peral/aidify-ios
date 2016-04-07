//
//  UserStats.swift
//  aidify
//
//  Created by salazar on 7/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

struct UserStats {
    let reputation: Int
    let impact: Int
    let helpful: Int
    let buggy: Int
    let total: Int
}

extension UserStats: JSONDecodable {
    init?(dictionary: JSONDictionary) {
        guard let reputation = dictionary["reputation"] as? Int, impact = dictionary["impact"] as? Int, helpful = dictionary["helpful"] as? Int, buggy = dictionary["buggy"] as? Int, total = dictionary["total"] as? Int else {
            return nil
        }
        
        self.reputation = reputation
        self.impact = impact
        self.helpful = helpful
        self.buggy = buggy
        self.total = total
    }
}

extension NSDateFormatter {
    static func RFC3339DateFormatter() -> NSDateFormatter {
        let RFC3339DateFormatter = NSDateFormatter()
        RFC3339DateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        return RFC3339DateFormatter
    }
}
