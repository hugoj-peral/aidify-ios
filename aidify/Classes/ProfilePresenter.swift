//
//  ProfilePresenter.swift
//  aidify
//
//  Created by Hugo Peral on 29/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol, ProfileInteractorOutputProtocol
{
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    
    init() {}
    
    //MARK: ProfilePresenterProtocol
    func needsShowPairBeacon() {
        interactor?.shouldShowPairBeacon()
    }
    
    func companyName() {
        interactor?.companyName()
    }
    
    func showSettings() {
        wireFrame?.presentSettings(fromView: view!)
    }
    
    func showActivity() {
        wireFrame?.presentActivity(fromView: view!)
    }
    
    func isUserLogged() {
        interactor?.isUserLogged()
    }
    
    //MARK: ProfileInteractorOutputProtocol
    func shouldShowPairBeacon() {
        wireFrame?.presentPairBeacon(fromView: view!)
    }
    
    func showLogin() {
        wireFrame?.presentLogin()
    }
    
    func setCompany(name name: String) {
        view?.setCompany(name: name)
    }
}