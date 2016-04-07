//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
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
        return 2 //self.activities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(ActivityCell.reuseIdentifier())!
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 54.0
    }
    
}

extension ActivityView: UITableViewDelegate {
    
}