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
    
    let kInterpolateStagesWithAlpha = true
    let kScrollViewTravel = 200.0
    let kMaximumBlurRadius = 25.0
    let kNumberOfStages = 10
    
    weak var piechart: Piechart?
    var presenter: ProfilePresenterProtocol?
    var stats: [UserItemProtocol]?
    
    var blurredImages : [UIImage] = []
//    var originalImage : UIImage
    
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
                
        let piechart = Piechart()
        
        piechart.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(piechart, belowSubview: tableView)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[piechart]-|", options: [], metrics: nil, views: views))
        
        self.piechart = piechart
        
        //initBlurredImages()
    }
    
    func initBlurredImages() {
        /*blurredImages.append(originalImage)
        
        for i in 1...kNumberOfStages {
            let radius = Double(i) * kMaximumBlurRadius / Double(kNumberOfStages)
            let blurredImage = blurOriginalImageWithRadius(radius)
            blurredImages.append(blurredImage)
            
            if i == kNumberOfStages {
                blurredImages.append(blurredImage)
            }
        }*/
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
    
    
    /*
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var r = Double(scrollView.contentOffset.y / CGFloat(kScrollViewTravel))
        var blur = max(0, min(1, r)) * Double(kNumberOfStages)
        var blurIndex = Int(blur)
        var blurRemainder = blur - Double(blurIndex)
        
        firstImageView.image = blurredImages[blurIndex]
        
        if kInterpolateStagesWithAlpha == true {
            secondImageView.image = blurredImages[blurIndex + 1]
            secondImageView.alpha = CGFloat(blurRemainder)
        }
    }
    
    func blurOriginalImageWithRadius(radius: Double) -> UIImage {
        return originalImage.applyBlurWithRadius(CGFloat(radius), tintColor: nil, saturationDeltaFactor: 1.0, maskImage: nil)
    }*/
    /*
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        var y = Double(targetContentOffset.memory.y)
        y = (y < kScrollViewTravel / 2.0) ? 0: kScrollViewTravel
        targetContentOffset.memory.y = CGFloat(y)
    }*/
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}