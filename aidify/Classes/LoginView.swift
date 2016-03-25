//
//  LoginView.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIViewController, LoginViewProtocol
{
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var usernameField: AIDTextField!
    @IBOutlet weak var passAndCo: UILabel!
    @IBOutlet weak var passAndCoField: AIDTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCompanyLookNFeel()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK: LoginViewProtocol
    var presenter: LoginPresenterProtocol?
    
    func loadCompanyLookNFeel() {
        view.backgroundColor = AIDColor.Purple.color()
        self.username.hidden = true
        self.usernameField.hidden = true
        self.passAndCo.text = "company"
        self.passAndCoField.placeholder = "your company"
        self.passAndCoField.secureTextEntry = false
    }
    
    func loadLoginLookNFeel() {
        view.backgroundColor = AIDColor.Blue.color()
        self.username.hidden = false
        self.usernameField.hidden = false
        self.passAndCo.text = "password"
        self.passAndCoField.placeholder = "your password"
        self.passAndCoField.secureTextEntry = true
    }
    
    func loadFailureLookNFeel() {
        view.backgroundColor = AIDColor.Pink.color()
    }
    
    func loadSuccessLookNFeel() {
        view.backgroundColor = AIDColor.Green.color()
    }
    
    func showRequestMode() {
        
    }
    
    func hideRequestMode() {
        
    }
}

//MARK: UIResponder
extension LoginView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
