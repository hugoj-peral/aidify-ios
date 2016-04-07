//
//  UserProfileItem.swift
//  aidify
//
//  Created by salazar on 7/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

struct UserProfileItem {
    let avatar: String
    let name: String?
    let username: String
}

extension UserProfileItem: UserItemProtocol{
    var cellDrawer: UserItemDrawerProtocol {
        return UserProfileItemDrawer()
    }
}

struct UserProfileItemDrawer: UserItemDrawerProtocol {
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(ProfileUserCell.reuseIdentifier()) as! ProfileUserCell
    }
    
    func estimatedHeight() -> CGFloat {
        return 99;
    }
    
    func drawCell(cell: UITableViewCell, withItem item: UserItemProtocol) {
        guard let cell = cell as? ProfileUserCell, item = item as? UserProfileItem else {
            return
        }
        
        cell.profileImage.loadImageFromURL(item.avatar)
        cell.profileTitleLabel.text = item.name
        cell.profileSubtitleLabel.text = item.username
    }
}