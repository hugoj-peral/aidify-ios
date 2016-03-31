//
//  AppDependencies.swift
//  aidify
//
//  Created by Hugo Peral on 20/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

class AppDependencies {
    
    let rootWireFrame = RootWireFrame()
    
    init () {
        customizeNavigationBar()
        customizeBackButton()
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow?) {
        guard let window = window else {
            fatalError("Error: no window")
        }
        
        rootWireFrame.window = window
        let userManager = UserManager()
        
        if(userManager.isAnyUserLogged()) {
            rootWireFrame.presentProfileModule()
        } else {
            rootWireFrame.presentLoginModule()
        }
    }
    
    //MARK: Private Methods 
    func customizeNavigationBar() {
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "AllerDisplay", size: 24.0)!]
    }
    
    func customizeBackButton() {
        let backImage = UIImage(named: "BackButton")?.resizableImageWithCapInsets(UIEdgeInsetsMake(0.0, 12.5, 0.0, 12.5), resizingMode: .Stretch)
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImage, forState: .Normal, barMetrics: .Default)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0.0, -80.0), forBarMetrics: .Default)
    }
}
