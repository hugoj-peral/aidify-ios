//
//  LoginLocalDataManager.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class LoginLocalDataManager: LoginLocalDataManagerInputProtocol
{
    var userManager: UserManagerProtocol?
    
    init() {}
    
    func saveLogged(userID userID: Int, username: String, company: String) {
        let user = User(userID: userID, username: username, company: company)
        self.userManager?.save(user: user)
    }
}