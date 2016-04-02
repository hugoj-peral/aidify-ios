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
}