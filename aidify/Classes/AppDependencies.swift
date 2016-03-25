//
//  AppDependencies.swift
//  aidify
//
//  Created by Hugo Peral on 20/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

class AppDependencies {
    
    func installRootViewControllerIntoWindow(window: UIWindow?) {
        guard let window = window else {
            fatalError("Error no window")
        }
        //TODO: We need root wireframe
        LoginWireFrame.presentLoginModule(fromWindow: window)
    }
}
