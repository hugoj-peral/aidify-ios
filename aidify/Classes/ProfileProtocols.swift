//
//  ProfileProtocols.swift
//  aidify
//
//  Created by Hugo Peral on 29/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

protocol ProfileViewProtocol: class
{
    var presenter: ProfilePresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func setCompany(name name: String)
}

protocol ProfileWireFrameProtocol: class
{
    var rootWireFrame: RootWireFrameProtocol? { get set }
    
    static func presentProfileModule(fromWindow window: AnyObject, rootWireFrame: RootWireFrameProtocol)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func presentPairBeacon(fromView view: AnyObject)
    func presentActivity(fromView view: AnyObject)
    func presentSettings(fromView view: AnyObject)
    func presentLogin()
}

protocol ProfilePresenterProtocol: class
{
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func needsShowPairBeacon()
    func companyName()
    func showSettings()
    func showActivity()
    func isUserLogged()
}

protocol ProfileInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func shouldShowPairBeacon()
    func showLogin()
    func setCompany(name name: String)
}

protocol ProfileInteractorInputProtocol: class
{
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var APIDataManager: ProfileAPIDataManagerInputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func shouldShowPairBeacon()
    func companyName()
    func isUserLogged()
}

protocol ProfileDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol ProfileAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol ProfileLocalDataManagerInputProtocol: class
{
    var userManager: UserManagerProtocol? { get set }
    /**
     * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
     */
    
    func hasCurrentUserBeaconPaired(completion: (Bool) -> Void)
    func isUserLogged(completion: (Bool) -> Void)
    func companyName(completion: (String) -> Void)
}
