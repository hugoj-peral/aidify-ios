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
    
    init() {}
    
    //MARK: SettingsPresenterProtocol
    
    func logOut() {
        interactor?.logOut()
    }
    
    //MARK: SettingsInteractorOutputProtocol
    func logOutDone() {
        wireFrame?.dissmisSettingModule(from: view)
    }
}