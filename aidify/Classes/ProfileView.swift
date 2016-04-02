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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.companyName()
        presenter?.needsShowPairBeacon()
        initializeView()
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
    
    //MARK: ProfileViewProtocol
    
    func setCompany(name name: String) {
        title = name.capitalizedString
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
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return (indexPath.row == 0) ? tableView.dequeueReusableCellWithIdentifier(ProfileUserCell.reuseIdentifier())! : tableView.dequeueReusableCellWithIdentifier(ProfilePunctuationCell.reuseIdentifier())!
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row == 0 ? 99 : 73
    }
    
}

extension ProfileView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}