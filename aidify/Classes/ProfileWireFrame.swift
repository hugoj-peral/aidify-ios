//
//  ProfileWireFrame.swift
//  aidify
//
//  Created by Hugo Peral on 29/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

class ProfileWireFrame: ProfileWireFrameProtocol
{
    weak var rootWireFrame: RootWireFrameProtocol?
    
    class func presentProfileModule(fromWindow window: AnyObject, rootWireFrame: RootWireFrameProtocol)
    {
        // Generating module components
        let view: ProfileViewProtocol = ProfileView()
        let presenter: protocol<ProfilePresenterProtocol, ProfileInteractorOutputProtocol> = ProfilePresenter()
        let interactor: ProfileInteractorInputProtocol = ProfileInteractor()
        let APIDataManager: ProfileAPIDataManagerInputProtocol = ProfileAPIDataManager()
        let localDataManager: ProfileLocalDataManagerInputProtocol = ProfileLocalDataManager()
        let wireFrame: ProfileWireFrameProtocol = ProfileWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        wireFrame.rootWireFrame = rootWireFrame
        localDataManager.userManager = UserManager()
        
        let navigationController = AIDNavigationController(rootViewController: (view as? UIViewController)!)
        navigationController.navigationBar.translucent = false
        let fromWindow = window as! UIWindow
        fromWindow.rootViewController = navigationController
    }
    
    func presentPairBeacon(fromView view: AnyObject) {
        PairingWireFrame.presentPairingModule(fromViewController: view)
    }
    
    func presentActivity(fromView view: AnyObject, withActivities activities:[UserActivity]){
        guard let navigationController = (view as! UIViewController).navigationController else { return }
        ActivityWireFrame.pushActivityModule(fromView: navigationController, withActivities:activities)
    }
    
    func presentSettings(fromView view: AnyObject) {
        guard let navigationController = (view as! UIViewController).navigationController else { return }
        SettingsWireFrame.pushSettingsModule(fromView: navigationController)
    }
    
    func presentLogin() {
        if let rootWireFrame = rootWireFrame {
            rootWireFrame.presentLoginModule()
        }
    }
}