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

struct UserActivity {
    let repo: String
    let type: UserActivityType
    let action: UserActivityAction
    let points: Int
    let createDate: NSDate
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
        self.createDate = NSDateFormatter.RFC3339DateFormatter().dateFromString(date) ?? NSDate()
    }
}