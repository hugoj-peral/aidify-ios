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
}

struct UserStatItem {
    let type: UserActivityCategory
    let value: Int
    let description: String
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
        
        cell.profileDescriptionLabel.text = item.description
        cell.profileColorView.backgroundColor = item.type.color
        cell.profileTitleLabel.text = item.type.name
        cell.profileSubtitleLabel.text = String(item.value)
        cell.expandCell(item.expanded)
    }
}

extension UserStats {
    func explode() -> [UserStatItem] {
        return [ UserStatItem(type: .Reputation, value: reputation, description: "Lorem", expanded: false), UserStatItem(type: .Impact, value: impact, description: "Lorem", expanded: false), UserStatItem(type: .Helpful, value: helpful, description: "Lorem", expanded: false), UserStatItem(type: .Buggy, value: buggy, description: "Lorem", expanded: false)]
    }
}
