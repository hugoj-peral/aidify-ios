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
}

protocol ProfileWireFrameProtocol: class
{
    var rootWireFrame: RootWireFrameProtocol? { get set }
    
    static func presentProfileModule(fromWindow window: AnyObject, rootWireFrame: RootWireFrameProtocol)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol ProfilePresenterProtocol: class
{
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol ProfileInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol ProfileInteractorInputProtocol: class
{
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var APIDataManager: ProfileAPIDataManagerInputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
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
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
