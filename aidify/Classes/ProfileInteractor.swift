//
//  ProfileInteractor.swift
//  aidify
//
//  Created by Hugo Peral on 29/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class ProfileInteractor: ProfileInteractorInputProtocol
{
    weak var presenter: ProfileInteractorOutputProtocol?
    var APIDataManager: ProfileAPIDataManagerInputProtocol?
    var localDatamanager: ProfileLocalDataManagerInputProtocol?
    
    init() {}
    
    func shouldShowPairBeacon() {
        localDatamanager?.hasCurrentUserBeaconPaired({ hasBeacon in
            if !hasBeacon {
                self.presenter?.shouldShowPairBeacon()
            }
        })
    }
    
    func companyName() {
        localDatamanager?.companyName({ company in
                self.presenter?.setCompany(name: company)
        })
    }
    
    func isUserLogged() {
        localDatamanager?.isUserLogged({ (isLogged) -> Void in
            if (!isLogged) {
                self.presenter?.showLogin()
            }
        })
    }
    
    func getUserProfile() {
        localDatamanager?.username({ (username) -> Void in
            if let username = username {
                self.APIDataManager?.getProfile(withUsername: username, completion: { result -> Void in
                    switch result {
                    case let .Success(userData):
                        self.presenter?.setUserProfile(userData)
                    case .Failure:
                        break
                    }
                })
            }
        })
    }
}