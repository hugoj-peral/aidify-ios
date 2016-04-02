//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation

protocol ActivityViewProtocol: class
{
    var presenter: ActivityPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol ActivityWireFrameProtocol: class
{
    static func pushActivityModule(fromView view: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol ActivityPresenterProtocol: class
{
    var view: ActivityViewProtocol? { get set }
    var interactor: ActivityInteractorInputProtocol? { get set }
    var wireFrame: ActivityWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol ActivityInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol ActivityInteractorInputProtocol: class
{
    var presenter: ActivityInteractorOutputProtocol? { get set }
    var APIDataManager: ActivityAPIDataManagerInputProtocol? { get set }
    var localDatamanager: ActivityLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}

protocol ActivityDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol ActivityAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol ActivityLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
