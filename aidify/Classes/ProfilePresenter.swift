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
    
    //MARK: ProfileInteractorOutputProtocol
    func shouldShowPairBeacon() {
        wireFrame?.presentPairBeacon(fromView: view!)
    }
}