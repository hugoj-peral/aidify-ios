//
//  ProfileLocalDataManager.swift
//  aidify
//
//  Created by Hugo Peral on 29/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class ProfileLocalDataManager: ProfileLocalDataManagerInputProtocol
{
    var userManager: UserManagerProtocol?
    
    init() {}
    
    func hasCurrentUserBeaconPaired(completion: (Bool) -> Void) {
        guard let userManager = userManager else {
            completion(false)
            return
        }
        
        var hasBeaconPaired = false
        if(userManager.isAnyUserLogged()) {
            if let user = userManager.currentUser {
                hasBeaconPaired = user.hasBeaconPaired()
            }
        }
        completion(hasBeaconPaired)
    }
    
    func isUserLogged(completion: (Bool) -> Void) {
        guard let userManager = userManager else {
            completion(false)
            return
        }
        completion(userManager.isAnyUserLogged())
    }
    
    func companyName(completion: (String) -> Void) {
        guard let userManager = userManager else {
            completion("")
            return
        }
        
        var company = ""
        if(userManager.isAnyUserLogged()) {
            if let user = userManager.currentUser {
                company = user.company
            }
        }
        completion(company)
    }
    
    func userID(completion: (Int?) -> Void) {
        guard let userManager = userManager else {
            return
        }
        
        completion(userManager.currentUser?.userID)
    }
}