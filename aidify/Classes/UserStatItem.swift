//
//  UserStatItemDrawer.swift
//  aidify
//
//  Created by salazar on 7/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

enum UserStatType: String{
    case Reputation
    case Impact
    case Helpful
    case Buggy
}

extension UserStatType {
    
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
    let type: UserStatType
    let value: Int
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
    
    func estimatedHeight() -> CGFloat {
        return 73;
    }
    
    func drawCell(cell: UITableViewCell, withItem item: UserItemProtocol) {
        guard let cell = cell as? ProfilePunctuationCell, item = item as? UserStatItem else {
            return
        }
        
        cell.profileColorView.backgroundColor = item.type.color
        cell.profileTitleLabel.text = item.type.name
        cell.profileSubtitleLabel.text = String(item.value)
    }
}

extension UserStats {
    func explode() -> [UserStatItem] {
        return [ UserStatItem(type: .Reputation, value: reputation), UserStatItem(type: .Impact, value: impact), UserStatItem(type: .Helpful, value: helpful), UserStatItem(type: .Buggy, value: buggy)]
    }
}
