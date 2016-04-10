//
//  SettingsLocalDataManager.swift
//  aidify
//
//  Created by Hugo Peral on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class SettingsLocalDataManager: SettingsLocalDataManagerInputProtocol
{
    var userManager: UserManagerProtocol?
    
    init() {}
    
    func logOut(completion: (Void) -> Void) {
        userManager?.logOut()
        completion()
    }
    
    func requestUser(completion: (User) -> Void) {
        if let user = userManager?.currentUser {
            completion(user)
        }
    }
    
    func unpairNearable() {
        userManager?.updateBeacon(nil)
        NearableManager.sharedInstance.stopMonitoring()
    }
}