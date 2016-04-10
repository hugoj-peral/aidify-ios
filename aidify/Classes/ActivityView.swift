//
//  aidify
//
//  Created by salazar on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//


import Foundation
import UIKit

class ActivityView: AIDViewController, ActivityViewProtocol
{
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ActivityPresenterProtocol?
    var activities: [UserActivity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        presenter?.dataRequest()
        view.backgroundColor = AIDColor.Purple.color()
        title = "Activity"
    }
    
    private func initializeView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerCell(ActivityCell.self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarColor = AIDColor.DarkPurple.color()
    }
    
    func setData(data: [UserActivity]) {
        self.activities = data
        self.tableView.reloadData()
    }
}

extension ActivityView: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = activities[indexPath.row]
        let cell = item.cellDrawer.cellForTableView(tableView)
        item.cellDrawer.drawCell(cell, withItem: item)
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        let item = activities[indexPath.row]
        return item.cellDrawer.estimatedHeight()
    }
    
}
