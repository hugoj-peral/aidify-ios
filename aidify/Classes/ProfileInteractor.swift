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
        localDatamanager?.hasCurrentUserBeaconPaired({[weak self] hasBeacon -> Void in
            if let strongSelf = self {
                strongSelf.presenter?.shouldShowPairBeacon()
            }
        })
    }
    
    func companyName() {
        localDatamanager?.companyName({ [weak self] company -> Void in
            if let strongSelf = self {
                strongSelf.presenter?.setCompany(name: company)
            }
        })
    }
}