//
//  File.swift
//  aidify
//
//  Created by salazar on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//


import Foundation

protocol PairingViewProtocol: class
{
    var presenter: PairingPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func loadPairingRequestLookNFeel()
    func loadPairingActionLookNFeel()
    func loadPairingSuccessfulLookNFeel(nearableId: String)
    func loadPairingFailureLookNFeel()
    func showNoBackgroundPermissions()
}

protocol PairingWireFrameProtocol: class
{
    static func presentPairingModule(fromViewController viewController: AnyObject)
    func dismissView(view: AnyObject?)
    func showAppSettings()
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol PairingPresenterProtocol: class
{
    var view: PairingViewProtocol? { get set }
    var interactor: PairingInteractorInputProtocol? { get set }
    var wireFrame: PairingWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    
    func initialLookNFeel()
    func primaryAction()
    func secondaryAction()
    func showAppSettings()
}

protocol PairingInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func pairingSuccessful(nearableId: String)
    func pairingFailure()
    func requestBackgroundSuccess()
    func requestBackgroundFail()
}

protocol PairingInteractorInputProtocol: class
{
    var presenter: PairingInteractorOutputProtocol? { get set }
    var APIDataManager: PairingAPIDataManagerInputProtocol? { get set }
    var localDatamanager: PairingLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func requestBackgroundAccess()
    
}

protocol PairingDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol PairingAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol PairingLocalDataManagerInputProtocol: class
{
    var userManager: UserManagerProtocol? { get set }
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
    
    func findClosestNearable(closure: ((PairingResult)->())?)
    func requestBackgroundAccess(closure: ((Bool)->())?)
}
