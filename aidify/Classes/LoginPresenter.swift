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
    var user: UserData?
    
    init() {}
    
    func initialLookNFeel() {
        self.view?.loadCompanyLookNFeel()
    }
    
    func nextLookNFeel() {
        switch self.look {
        case .Company: self.showUsername()
        case .Login: self.performLogin()
        case .Error: self.performLogin()
        case .Success:
            guard let user = user else {
                return
            }
            
            self.wireFrame?.dismissLogin(user)
        }
    }
    
    func setUsernameAndCoText(text:String?) {
        switch self.look {
        case .Company: loginItem.company = text
        default: loginItem.username = text
        }
    }
    
    func setCompany(text:String?) {
        loginItem.company = text
    }
    
    func loginSuccess(user: UserData) {
        self.user = user
        self.look = .Success
        self.view?.hideRequestMode()
        self.view?.loadSuccessLookNFeel(username: self.loginItem.username!, company: self.loginItem.company!)
    }
    
    func loginFailed() {
        self.look = .Error
        self.view?.hideRequestMode()
        self.view?.loadFailureLookNFeel(username: self.loginItem.username!, company: self.loginItem.company!)
    }
    
    //MARK: Private
    private var look: LoginLookNFeel = .Company
    private var loginItem = LoginItem()
    
    func shouldShowUsername() -> Bool {
        if let company = self.loginItem.company {
            if (company != "") {
                return true
            }
        }
        return false
    }
    
    func showUsername() {
        if(self.shouldShowUsername()) {
            self.look = .Login
            self.view?.loadLoginLookNFeel()
        }
    }
    
    func shouldPerformLogin() -> Bool {
        if let username = self.loginItem.username, company = self.loginItem.company {
            if(username != "" && company != "") {
                return true
            }
        }
        return false
    }
    
    func performLogin(){
        if(self.shouldPerformLogin()) {
            self.view?.showRequestMode()
            self.interactor?.loginWith(loginItem: self.loginItem)
        }
    }
}
