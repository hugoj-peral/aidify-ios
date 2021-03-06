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
    
    let kScrollViewTravel = 400.0
    let kMaximumBlurRadius = 20.5
    let kNumberOfStages = 10
    var footerHeight: CGFloat = -1
    
    weak var piechart: Piechart?
    weak var background: UIImageView?
    var presenter: ProfilePresenterProtocol?
    var stats: [UserItemProtocol]?
    
    var blurredImages : [UIImage] = []
    var originalImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.companyName()
        presenter?.needsShowPairBeacon()
        presenter?.requestData()
        initializeView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarColor = AIDColor.DarkOrange.color()
        piechart?.setNeedsDisplay()
        presenter?.isUserLogged()
    }
    
    private func initializeView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerCell(ProfileUserCell.self)
        tableView.registerCell(ProfilePunctuationCell.self)
        addNavigationBarRightButtons()
        addProfileChart()
        addBackgroundImage()
    }
    
    private func addProfileChart() {
        let piechart = Piechart()
        addViewBelowTable(piechart)
        self.piechart = piechart
    }
    
    private func addBackgroundImage() {
        let image = UIImageView()
        image.backgroundColor = UIColor.clearColor()
        addViewBelowTable(image)
        self.background = image
    }
    
    private func addViewBelowTable(newView: UIView) {
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(newView, belowSubview: tableView)
        let views = ["newView": newView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[newView]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[newView]|", options: [], metrics: nil, views: views))
    }
    
    private func initBlurredImages() {
        originalImage = piechart?.takeSnapshot()
        blurredImages.append(originalImage)
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.blurredImages = self.originalImage.blurOriginalImage(withStages: self.kNumberOfStages, maximumBlurRadius: self.kMaximumBlurRadius)
        }
    }
    
    //MARK: ProfileViewProtocol
    
    func setCompany(name name: String) {
        title = name.capitalizedString
    }
    
    func setData(data: [UserItemProtocol]) {
        self.stats = data
        
        var items: [UserStatItem] = []
        for item in data {
            if let item = item as? UserStatItem {
                items.append(item)
            }
        }
        
        self.piechart?.slices = items
        self.piechart?.setNeedsDisplay()
        self.tableView.reloadData()
        initBlurredImages()
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
        return item.cellDrawer.estimatedHeight(item)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let profileCell = self.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: section))
        return tableView.frame.size.height - profileCell.frame.size.height + 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if footerHeight > 0 {
            return footerHeight
        }
        
        footerHeight = calculateFooterHeight(tableView, heightForFooterInSection: section)
        return footerHeight
    }
    
    func calculateFooterHeight(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var heightToFill = tableView.frame.size.height
        
        if let stats = stats {
            for (index, _) in stats.enumerate() {
                let cell = self.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: section))
                heightToFill -= cell.frame.size.height  - 1
            }
        }
        return max(heightToFill, 0)
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = AIDColor.Orange.color()
        return view
    }
}

extension ProfileView: UITableViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let r = Double(scrollView.contentOffset.y / CGFloat(kScrollViewTravel))
        let blur = max(0, min(1, r)) * Double(kNumberOfStages)
        let blurIndex = Int(blur)
        
        background?.image = blurredImages[blurIndex]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard var stats = stats, item = stats[indexPath.row] as? UserStatItem, let cell = tableView.cellForRowAtIndexPath(indexPath) as? ProfilePunctuationCell else {
            return
        }
        
        item.expanded = !item.expanded
        self.stats![indexPath.row] = item
        cell.expandCell(item.expanded)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}