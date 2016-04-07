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
    case Reputation
    case Impact
    case Helpful
    case Buggy
}

struct UserActivity {
    let repo: String
    let type: UserActivityType
    let action: UserActivityAction
    let category: UserActivityCategory
    let points: Int
    let creationDate: NSDate
}

extension UserActivity: JSONDecodable {
    init?(dictionary: JSONDictionary) {
        guard let repo = dictionary["repo"] as? String, typeRawValue = dictionary["type"] as? String, actionRawValue = dictionary["action"] as? String, points = dictionary["points"] as? Int, date = dictionary["createdAt"] as? String, type = UserActivityType(rawValue: typeRawValue), action = UserActivityAction(rawValue: actionRawValue) else {
            return nil
        }
        
        self.repo = repo
        self.type = type
        self.action = action
        self.points = points
        self.category = .Reputation
        self.creationDate = NSDateFormatter.ISO8601DateFormatter().dateFromString(date) ?? NSDate()
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
