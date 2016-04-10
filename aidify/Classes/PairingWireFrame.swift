//
//  File.swift
//  aidify
//
//  Created by salazar on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//


import Foundation
import UIKit

class PairingWireFrame: PairingWireFrameProtocol
{
    class func presentPairingModule(fromViewController viewController: AnyObject)
    {
        // Generating module components
        let view: PairingViewProtocol = PairingView()
        let presenter: protocol<PairingPresenterProtocol, PairingInteractorOutputProtocol> = PairingPresenter()
        let interactor: PairingInteractorInputProtocol = PairingInteractor()
        let APIDataManager: PairingAPIDataManagerInputProtocol = PairingAPIDataManager()
        let localDataManager: PairingLocalDataManagerInputProtocol = PairingLocalDataManager()
        let wireFrame: PairingWireFrameProtocol = PairingWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        localDataManager.userManager = UserManager()
        
        let viewController = viewController as? UIViewController
        viewController?.presentViewController(view as! UIViewController, animated: true, completion: nil)
    }
    
    func dismissView(view: AnyObject?) {
        guard let viewController = view as? UIViewController else { return }
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showAppSettings() {
        if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
}