//
//  UserActivity.swift
//  aidify
//
//  Created by salazar on 7/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

enum UserActivityType:String {
    case Commit = "commit"
    case Issue = "issuesevent"
    case Push = "pushevent"
    case PullRequest = "pullrequestevent"
}

enum UserActivityAction:String {
    case Opened = "opened"
    case Closed = "closed"
    case Reopened = "reopened"
    case Created = "created"
    case Merged = "merged"
}

enum UserActivityCategory: String{
    case Reputation = "reputation"
    case Impact = "impact"
    case Helpful = "helpful"
    case Buggy = "buggy"
}

struct UserActivity {
    let repo: String
    let type: UserActivityType
    let action: UserActivityAction
    let points: Int
    let creationDate: NSDate
    let affectedStats: [UserActivityCategory]
}

extension UserActivity: JSONDecodable {
    init?(dictionary: JSONDictionary) {
        guard let repo = dictionary["repo"] as? String, typeRawValue = dictionary["type"] as? String, actionRawValue = dictionary["action"] as? String, points = dictionary["points"] as? Int, date = dictionary["createdAt"] as? String, type = UserActivityType(rawValue: typeRawValue), action = UserActivityAction(rawValue: actionRawValue), affectedStats = dictionary["affectedStats"] as? [String] else {
            return nil
        }
        
        self.repo = repo
        self.type = type
        self.action = action
        self.points = points
        self.creationDate = NSDateFormatter.ISO8601DateFormatter().dateFromString(date) ?? NSDate()
        self.affectedStats = affectedStats.map { UserActivityCategory(rawValue: $0)! }
    }
}

extension NSDateFormatter {
    static func ISO8601DateFormatter() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        return dateFormatter
    }
}
