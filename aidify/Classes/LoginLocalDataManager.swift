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
    var storage: NSUserDefaults?
    
    init() {}
    
    func saveLogged() {
        self.storage?.setBool(true, forKey: "user_logged")
    }
}