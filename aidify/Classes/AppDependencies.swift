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
}
