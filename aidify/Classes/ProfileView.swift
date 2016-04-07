//
//  ProfileView.swift
//  aidify
//
//  Created by Hugo Peral on 29/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: AIDViewController, ProfileViewProtocol
{
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ProfilePresenterProtocol?
    var stats: [UserItemProtocol]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.companyName()
        presenter?.needsShowPairBeacon()
        presenter?.requestData()
        initializeView()
        addProfileChart()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarColor = AIDColor.DarkOrange.color()
        presenter?.isUserLogged()
    }
    
    private func initializeView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerCell(ProfileUserCell.self)
        tableView.registerCell(ProfilePunctuationCell.self)
        tableView.registerCell(ProfilePunctuationMeaningCell.self)
        addNavigationBarRightButtons()
    }
    
    private func addProfileChart() {
        var views: [String: UIView] = [:]
        
        var error = Piechart.Slice()
        error.value = 3234
        error.color =  AIDColor.Green.color()
        
        var zero = Piechart.Slice()
        zero.value = 2555
        zero.color = AIDColor.Orange.color()
        
        var win = Piechart.Slice()
        win.value = 1000
        win.color = AIDColor.Blue.color()
        
        var win2 = Piechart.Slice()
        win2.value = 200
        win2.color = AIDColor.Pink.color()
        
        let piechart = Piechart()
        piechart.slices = [error, zero, win, win2]
        
        piechart.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(piechart, belowSubview: tableView)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[piechart(==500)]", options: [], metrics: nil, views: views))
        
    }
    
    //MARK: ProfileViewProtocol
    
    func setCompany(name name: String) {
        title = name.capitalizedString
    }
    
    func setData(data: [UserItemProtocol]) {
        self.stats = data
        self.tableView.reloadData()
    }
    
    //MARK: Actions
    
    func showSettings() {
        presenter?.showSettings()
    }
    
    func showActivity() {
        presenter?.showActivity()
    }
    
    //MARK: Private Methods
    
    private struct kBarButtonsSizes {
        static let width = CGFloat(31.0)
        static let height = CGFloat(31.0)
        static let padding = CGFloat(8.0)
    }
    
    private func addNavigationBarRightButtons() {
        
        let buttons = UIView(frame: CGRectMake(0.0, 0.0, 2.0 * kBarButtonsSizes.width + kBarButtonsSizes.padding, kBarButtonsSizes.height))
        buttons.addSubview(createSettingsButton())
        buttons.addSubview(createActivityButton())
        
        let rightBarButton = UIBarButtonItem(customView: buttons)
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func createSettingsButton() -> UIButton {
        let settingsImage = UIImage(named: "SettingsButton")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let settingsButton = UIButton(type: .Custom)
        settingsButton.frame = CGRectMake(kBarButtonsSizes.width + kBarButtonsSizes.padding, 0.0, kBarButtonsSizes.width, kBarButtonsSizes.height)
        settingsButton.setImage(settingsImage, forState: .Normal)
        settingsButton.addTarget(self, action: "showSettings", forControlEvents: .TouchUpInside)
        return settingsButton
    }
    
    private func createActivityButton() -> UIButton {
        let activityImage = UIImage(named: "ActivityButton")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let activityButton = UIButton(type: .Custom)
        activityButton.frame = CGRectMake(0.0, 0.0, kBarButtonsSizes.width, kBarButtonsSizes.height)
        activityButton.setImage(activityImage, forState: .Normal)
        activityButton.addTarget(self, action: "showActivity", forControlEvents: .TouchUpInside)
        return activityButton
    }
}

extension ProfileView: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return stats?.count > 0 ? 1 : 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let stats = stats else {
            return UITableViewCell()
        }
        
        let item = stats[indexPath.row]
        let cell = item.cellDrawer.cellForTableView(tableView)
        item.cellDrawer.drawCell(cell, withItem: item)
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let stats = stats else {
            return 0
        }
        
        let item = stats[indexPath.row]
        return item.cellDrawer.estimatedHeight()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let profileCell = self.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: section))
        return tableView.frame.size.height - profileCell.frame.size.height + 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var heightToFill = tableView.frame.size.height
        
        if let stats = stats {
            for (index, _) in stats.enumerate() {
                let cell = self.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: section))
                heightToFill -= cell.frame.size.height
            }
        }
        
        return max(heightToFill, 0)
    }
    
}

extension ProfileView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}