//
//  ActivityDrawer.swift
//  aidify
//
//  Created by salazar on 7/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

extension UserActivityType {
    var description: String {
        switch self {
        case .Commit:
            return "Commit"
        case .Issue:
            return "Issue"
        case .Push:
            return "Push"
        case .PullRequest:
            return "Pull request"
        }
    }
}

extension UserActivity {
    
    var title: String {
        return "\(type.description) \(action.rawValue)!"
    }
    
    var subtitle: String {
        
        var categoriesString = affectedStats.map { $0.rawValue.capitalizedString }.joinWithSeparator(", ")
        if (affectedStats.count > 0) {
            categoriesString = categoriesString.stringByReplacingCharactersInRange(categoriesString.rangeOfString(",", options: .BackwardsSearch)!, withString: " and")
        }
        
        return  points >= 0 ? "You earned \(points)pts in \(categoriesString) for this great \(type.description.lowercaseString)!" : "You lost \(-points)pts in \(categoriesString).\nThis sucks man!"
    }
    
    var image: UIImage? {
        let value = Int(arc4random_uniform(3) + 1)
        let baseString = points >= 0 ? "good0" : "bad0"
        return UIImage(named: "\(baseString)\(value)")
    }
    
    var shortDate: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        
        return dateFormatter.stringFromDate(creationDate)
    }
}


extension UserActivity: UserActivityItemProtocol {
    var cellDrawer: UserActivityItemDrawerProtocol {
        return UserActivityItemDrawer()
    }
}

struct UserActivityItemDrawer: UserActivityItemDrawerProtocol {
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(ActivityCell.reuseIdentifier()) as! ActivityCell
    }
    
    func estimatedHeight() -> CGFloat {
        return 54.0
    }
    
    func drawCell(cell: UITableViewCell, withItem item: UserActivityItemProtocol) {
        guard let cell = cell as? ActivityCell, item = item as? UserActivity else {
            return
        }
        
        cell.activityDateLabel.text = item.shortDate
        cell.activityImage.image = item.image
        cell.activityTitleLabel.text = item.title
        cell.activitySubtitleLabel.text = item.subtitle
    }
}