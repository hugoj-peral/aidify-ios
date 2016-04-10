//
//  SettingsWireFrame.swift
//  aidify
//
//  Created by Hugo Peral on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

class SettingsWireFrame: SettingsWireFrameProtocol
{
    class func pushSettingsModule(fromView view: AnyObject)
    {
        // Generating module components
        let settingsView: SettingsViewProtocol = SettingsView.create()
        let presenter: protocol<SettingsPresenterProtocol, SettingsInteractorOutputProtocol> = SettingsPresenter()
        let interactor: SettingsInteractorInputProtocol = SettingsInteractor()
        let APIDataManager: SettingsAPIDataManagerInputProtocol = SettingsAPIDataManager()
        let localDataManager: SettingsLocalDataManagerInputProtocol = SettingsLocalDataManager()
        let wireFrame: SettingsWireFrameProtocol = SettingsWireFrame()
        
        // Connecting
        settingsView.presenter = presenter
        presenter.view = settingsView
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        localDataManager.userManager = UserManager()
        
        let navigationController = view as? UINavigationController
        navigationController?.pushViewController(settingsView as! UIViewController, animated: true)
    }
    
    func dissmisSettingModule(from view: AnyObject?) {
        guard let view = view else { return }
        if let view = view as? UIViewController, navigationController = view.navigationController {
            navigationController.popToRootViewControllerAnimated(false)
        }
    }
    
    func presentPairBeacon(fromView view: AnyObject) {
        PairingWireFrame.presentPairingModule(fromViewController: view)
    }
}