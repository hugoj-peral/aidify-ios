//
//  SettingsInteractor.swift
//  aidify
//
//  Created by Hugo Peral on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class SettingsInteractor: SettingsInteractorInputProtocol
{
    weak var presenter: SettingsInteractorOutputProtocol?
    var APIDataManager: SettingsAPIDataManagerInputProtocol?
    var localDatamanager: SettingsLocalDataManagerInputProtocol?
    
    init() {}
    
    func logOut() {
        localDatamanager?.logOut({ [weak self] () -> Void in
            if let strongSelf = self {
                strongSelf.presenter?.logOutDone()
            }
        })
    }
    
    func requestUser() {
        localDatamanager?.requestUser({ self.presenter?.setUser($0)})
    }
    
    func unpairNearable() {
        localDatamanager?.unpairNearable()
    }
}