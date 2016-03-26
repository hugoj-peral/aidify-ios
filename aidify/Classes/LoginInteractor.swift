//
//  LoginInteractor.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol
{
    weak var presenter: LoginInteractorOutputProtocol?
    var APIDataManager: LoginAPIDataManagerInputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    
    init() {}
    
    func loginWith(loginItem loginItem: LoginItem) {
        
        if let username = loginItem.username, password = loginItem.password {
            self.APIDataManager?.githubLoginWith(usermane: username, password: password)
        } else {
            print("Error: username or password empty")
        }
    }
}