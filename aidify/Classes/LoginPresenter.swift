//
//  LoginPresenter.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

enum LoginLookNFeel {
    case Company, Login, Error, Success;
}

class LoginPresenter: LoginPresenterProtocol, LoginInteractorOutputProtocol
{
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    
    init() {}
    
    func initialLookNFeel() {
        self.view?.loadCompanyLookNFeel()
    }
    
    func nextLookNFeel() {
        switch self.look {
        case .Company: self.showUsernameAndPassword()
        case .Login: self.performLogin()
        default: break
        }
    }
    
    func setPassAndCoText(text:String?) {
        switch self.look {
        case .Company: loginItem.company = text
        default: loginItem.password = text
        }
    }
    
    func setUserName(text:String?) {
        loginItem.username = text
    }
    
    //MARK: Private
    private var look: LoginLookNFeel = .Company
    private var loginItem = LoginItem()
    
    func shouldShowUsernameAndPassword() -> Bool {
        if let company = self.loginItem.company {
            if (company != "") {
                return true
            }
        }
        return false
    }
    
    func showUsernameAndPassword() {
        if(self.shouldShowUsernameAndPassword()) {
            self.look = .Login
            self.view?.loadLoginLookNFeel()
        }
    }
    
    func shouldPerformLogin() -> Bool {
        if let username = self.loginItem.username, password = self.loginItem.password {
            if(username != "" && password != "") {
                return true
            }
        }
        return false
    }
    
    func performLogin(){
        if(self.shouldPerformLogin()) {
            self.view?.showRequestMode()
            //TODO: API Call
        }
    }
}