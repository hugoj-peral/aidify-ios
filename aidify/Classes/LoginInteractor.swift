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
        
        if let username = loginItem.username, company = loginItem.company {
            self.APIDataManager?.loginWith(usermane: username, company: company, completion: { result -> Void in
                switch result {
                case let .Success(userData):
                    self.localDatamanager?.saveLogged(userID:userData.userID, username: username, company: company)
                    self.presenter?.loginSuccess(userData)
                case .Failure:
                    self.presenter?.loginFailed()
                }
            })
        } else {
            print("Error: username or password empty")
            self.presenter?.loginFailed()
        }
    }
}