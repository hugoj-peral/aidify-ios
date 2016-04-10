//
//  UserItemProtocol.swift
//  aidify
//
//  Created by salazar on 7/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

protocol UserItemProtocol {
    var cellDrawer: UserItemDrawerProtocol { get }
}

protocol UserItemDrawerProtocol {
    func cellForTableView(tableView: UITableView) -> UITableViewCell
    func drawCell(cell: UITableViewCell, withItem item: UserItemProtocol)
    func estimatedHeight(item: UserItemProtocol) -> CGFloat
}
