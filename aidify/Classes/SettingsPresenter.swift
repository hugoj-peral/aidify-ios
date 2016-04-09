//
//  SettingsPresenter.swift
//  aidify
//
//  Created by Hugo Peral on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class SettingsPresenter: SettingsPresenterProtocol, SettingsInteractorOutputProtocol
{
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInteractorInputProtocol?
    var wireFrame: SettingsWireFrameProtocol?
    
    var user: User?
    
    init() {}
    
    //MARK: SettingsPresenterProtocol
    
    func logOut() {
        interactor?.logOut()
    }
    
    func requestNearableIdentifier() {
        
        if let user = user {
            view?.setNearableIdentifier(user.beaconId)
        } else {
            interactor?.requestUser()
        }
    }
    
    func requestPairing() {
        wireFrame?.presentPairBeacon(fromView: view!)
    }
    
    func requestUnpairing() {
        interactor?.unpairNearable()
    }
    
    //MARK: SettingsInteractorOutputProtocol
    func logOutDone() {
        wireFrame?.dissmisSettingModule(from: view)
    }
    
    func setUser(user: User) {
        self.user = user
        view?.setNearableIdentifier(user.beaconId)
    }
}