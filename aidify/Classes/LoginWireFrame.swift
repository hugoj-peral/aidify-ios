//
//  LoginWireFrame.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

class LoginWireFrame: LoginWireFrameProtocol
{
    weak var rootWireFrame: RootWireFrameProtocol?
    
    class func presentLoginModule(fromWindow window: AnyObject, rootWireFrame: RootWireFrameProtocol)
    {
        // Generating module components
        let view: LoginViewProtocol = LoginView()
        let presenter: protocol<LoginPresenterProtocol, LoginInteractorOutputProtocol> = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let APIDataManager: LoginAPIDataManagerInputProtocol = LoginAPIDataManager()
        let localDataManager: LoginLocalDataManagerInputProtocol = LoginLocalDataManager()
        let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        localDataManager.userManager = UserManager()
        wireFrame.rootWireFrame = rootWireFrame
        
        let fromWindow = window as! UIWindow
        fromWindow.rootViewController = view as? UIViewController
    }
    
    func dismissLogin(user: UserData) {
        if let rootWireFrame = rootWireFrame {
            rootWireFrame.presentProfileModule()
        }
    }
}
