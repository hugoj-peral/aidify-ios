//
//  UserStatItemDrawer.swift
//  aidify
//
//  Created by salazar on 7/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

extension UserActivityCategory {
    
    var color: UIColor {
        switch self {
        case .Reputation:
            return AIDColor.Green.color()
        case .Impact:
            return AIDColor.Pink.color()
        case .Helpful:
            return AIDColor.Orange.color()
        case .Buggy:
            return AIDColor.Blue.color()
        }
    }
    
    var name: String {
        return self.rawValue
    }
    
    var description: String {
        switch self {
        case .Reputation:
            return "how good you are at coding"
        case .Impact:
            return "your activity in the repos you work with. Everyhing count, so keep coding!"
        case .Helpful:
            return "you are always ready to give a helpful hand"
        case .Buggy:
            return "do not let this increase too much..."
        }
    }
}

struct UserStatItem {
    let type: UserActivityCategory
    let value: Int
    var expanded: Bool
}

extension UserStatItem: UserItemProtocol {
    var cellDrawer: UserItemDrawerProtocol {
        return UserStatItemDrawer()
    }
}

struct UserStatItemDrawer: UserItemDrawerProtocol {
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(ProfilePunctuationCell.reuseIdentifier()) as! ProfilePunctuationCell
    }
    
    func estimatedHeight(item: UserItemProtocol) -> CGFloat {
        guard let item = item as? UserStatItem else {
            return 0
        }
        
        return  item.expanded ? 120 : 73
    }
    
    func drawCell(cell: UITableViewCell, withItem item: UserItemProtocol) {
        guard let cell = cell as? ProfilePunctuationCell, item = item as? UserStatItem else {
            return
        }
        
        cell.profileDescriptionLabel.text = item.type.description
        cell.profileColorView.backgroundColor = item.type.color
        cell.profileTitleLabel.text = item.type.name
        cell.profileSubtitleLabel.text = String(item.value)
        cell.expandCell(item.expanded)
    }
}

extension UserStats {
    func explode() -> [UserStatItem] {
        return [ UserStatItem(type: .Reputation, value: reputation, expanded: false), UserStatItem(type: .Impact, value: impact, expanded: false), UserStatItem(type: .Helpful, value: helpful, expanded: false), UserStatItem(type: .Buggy, value: buggy, expanded: false)]
    }
}
