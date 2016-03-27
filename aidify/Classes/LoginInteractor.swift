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
            self.APIDataManager?.loginWith(usermane: username, company: company, completion: { [weak self]login -> Void in
                guard let strongSelf = self else { return }
                login ? strongSelf.presenter?.loginSuccess() : strongSelf.presenter?.loginFailed()
            })
        } else {
            print("Error: username or password empty")
            self.presenter?.loginFailed()
        }
    }
}