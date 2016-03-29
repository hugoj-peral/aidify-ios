//
//  ProfileWireFrame.swift
//  aidify
//
//  Created by Hugo Peral on 29/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class ProfileWireFrame: ProfileWireFrameProtocol
{
    class func presentProfileModule(fromView view: AnyObject)
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
    }
}