//
//  SettingsPresenter.swift
//  aidify
//
//  Created by Hugo Peral on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

protocol SettingsViewProtocol: class
{
    var presenter: SettingsPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol SettingsWireFrameProtocol: class
{
    static func pushSettingsModule(fromView view: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func dissmisSettingModule(from view: AnyObject?)
}

protocol SettingsPresenterProtocol: class
{
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorInputProtocol? { get set }
    var wireFrame: SettingsWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func logOut()
}

protocol SettingsInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func logOutDone()
}

protocol SettingsInteractorInputProtocol: class
{
    var presenter: SettingsInteractorOutputProtocol? { get set }
    var APIDataManager: SettingsAPIDataManagerInputProtocol? { get set }
    var localDatamanager: SettingsLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func logOut()
}

protocol SettingsDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol SettingsAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol SettingsLocalDataManagerInputProtocol: class
{
    var userManager: UserManagerProtocol? { get set }
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
    func logOut(completion: (Void) -> Void)
}
