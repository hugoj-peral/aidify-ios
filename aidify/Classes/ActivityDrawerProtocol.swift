//
//  ActivityDrawerProtocol.swift
//  aidify
//
//  Created by salazar on 7/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

protocol UserActivityItemProtocol {
    var cellDrawer: UserActivityItemDrawerProtocol { get }
}

protocol UserActivityItemDrawerProtocol {
    func cellForTableView(tableView: UITableView) -> UITableViewCell
    func drawCell(cell: UITableViewCell, withItem item: UserActivityItemProtocol)
    func estimatedHeight() -> CGFloat
}
