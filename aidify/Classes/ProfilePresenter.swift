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
    var userProfile: UserData?
    
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
        wireFrame?.presentActivity(fromView: view!, withActivities: userProfile?.activities ?? [])
    }
    
    func isUserLogged() {
        interactor?.isUserLogged()
    }
    
    func requestData() {
        
        if let userProfile = userProfile {
            setUserProfile(userProfile)
        } else {
            interactor?.getUserProfile()
        }
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
    
    func setUserProfile(userProfile: UserData) {
        self.userProfile = userProfile
        
        var items: [UserItemProtocol] = [UserProfileItem(avatar: userProfile.avatar, name: userProfile.realName, username: userProfile.name)]
        for item in userProfile.stats.explode() {
            items.append(item)
        }
        
        view?.setData(items)
    }
}