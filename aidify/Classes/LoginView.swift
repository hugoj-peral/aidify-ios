//
//  LoginView.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

class LoginView: AIDViewController, LoginViewProtocol
{
    @IBOutlet weak var companyField: AIDTextField!
    @IBOutlet weak var usernameAndCo: UILabel!
    @IBOutlet weak var usernameAndCoField: AIDTextField!
    @IBOutlet weak var usernameAndCoHeight: NSLayoutConstraint!
    
    lazy var progressView: AIDProgressView = {
        var frame = self.statusBarFrame()
        frame.origin.y = frame.size.height
        frame.size.height = 4.0
        let progressView = AIDProgressView(frame: frame)
        return progressView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.initialLookNFeel()
    }
    
    //MARK: LoginViewProtocol
    var presenter: LoginPresenterProtocol?
    
    func loadCompanyLookNFeel() {
        UIView .animateWithDuration(0.4) { () -> Void in
            self.view.backgroundColor = AIDColor.Purple.color()
            self.statusBarColor = AIDColor.DarkPurple.color()
            self.companyField.hidden = true
            self.usernameAndCo.text = "company"
            self.usernameAndCoField.text = nil;
            self.usernameAndCoField.placeholder = "your company"
        }
    }
    
    func loadLoginLookNFeel() {
        UIView .animateWithDuration(0.4) { () -> Void in
            self.view.backgroundColor = AIDColor.Blue.color()
            self.statusBarColor = AIDColor.DarkBlue.color()
            self.companyField.hidden = true
            self.usernameAndCo.text = "username"
            self.usernameAndCoField.text = nil
            self.usernameAndCoField.placeholder = "your username"
        }
    }
    
    func loadFailureLookNFeel() {
        UIView .animateWithDuration(0.4) { () -> Void in
            self.view.backgroundColor = AIDColor.Pink.color()
            self.statusBarColor = AIDColor.DarkPink.color()
        }
    }
    
    func loadSuccessLookNFeel() {
        UIView .animateWithDuration(0.4) { () -> Void in
            self.view.backgroundColor = AIDColor.Green.color()
            self.statusBarColor = AIDColor.DarkGreen.color()
        }
    }
    
    func showRequestMode() {
        progressView.progress = 0.0
        view.addSubview(progressView)
        progressView.simulateProgress()
    }
    
    func hideRequestMode() {
        progressView.progress = 1.0
        let delayInSeconds = 0.5
        let popTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue()) {[weak self]() -> Void in
            guard let strongSelf = self else { return }
            strongSelf.progressView.removeFromSuperview()
        }
    }
}

//MARK: UIResponder
extension LoginView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField == self.usernameAndCoField) {
            self.presenter?.setUsernameAndCoText(textField.text)
        } else if(textField == self.companyField) {
            self.presenter?.setCompany(textField.text)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.companyField) {
            self.usernameAndCoField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        self.presenter?.nextLookNFeel()
        return true
    }
}
