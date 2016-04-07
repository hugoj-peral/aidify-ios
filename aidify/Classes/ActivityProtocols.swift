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
    func setData(data: [UserActivity])
}

protocol ActivityWireFrameProtocol: class
{
    static func pushActivityModule(fromView view: AnyObject, withActivities activities:[UserActivity])
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
    
    func dataRequest()
}

protocol ActivityInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func setActivities(activities: [UserActivity])
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
