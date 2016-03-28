//
//  LoginProtocols.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: class
{
    var presenter: LoginPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func loadCompanyLookNFeel()
    func loadLoginLookNFeel()
    func loadFailureLookNFeel(username username: String, company: String)
    func loadSuccessLookNFeel(username username: String, company: String)
    func showRequestMode()
    func hideRequestMode()
}

protocol LoginWireFrameProtocol: class
{
    static func presentLoginModule(fromWindow window: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func dismissLogin()
}

protocol LoginPresenterProtocol: class
{
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    
    func initialLookNFeel()
    func nextLookNFeel()
    func setUsernameAndCoText(text:String?)
    func setCompany(text:String?)
}

protocol LoginInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func loginSuccess()
    func loginFailed()
}

protocol LoginInteractorInputProtocol: class
{
    var presenter: LoginInteractorOutputProtocol? { get set }
    var APIDataManager: LoginAPIDataManagerInputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func loginWith(loginItem loginItem: LoginItem)
}

protocol LoginDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol LoginAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
    func loginWith(usermane username: String, company: String, completion: (Bool) -> Void)
}

protocol LoginLocalDataManagerInputProtocol: class
{
    var storage: NSUserDefaults? { get set }
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
    
    func saveLogged()
}
