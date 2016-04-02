//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import UIKit

class ActivityWireFrame: ActivityWireFrameProtocol
{
    class func pushActivityModule(fromView view: AnyObject)
    {
        // Generating module components
        let activityView: ActivityViewProtocol = ActivityView()
        let presenter: protocol<ActivityPresenterProtocol, ActivityInteractorOutputProtocol> = ActivityPresenter()
        let interactor: ActivityInteractorInputProtocol = ActivityInteractor()
        let APIDataManager: ActivityAPIDataManagerInputProtocol = ActivityAPIDataManager()
        let localDataManager: ActivityLocalDataManagerInputProtocol = ActivityLocalDataManager()
        let wireFrame: ActivityWireFrameProtocol = ActivityWireFrame()
        
        // Connecting
        activityView.presenter = presenter
        presenter.view = activityView
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        
        let navigationController = view as? UINavigationController
        navigationController?.pushViewController(activityView as! UIViewController, animated: true)
    }
}