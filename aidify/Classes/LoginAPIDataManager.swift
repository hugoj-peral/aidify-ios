//
//  LoginAPIDataManager.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class LoginAPIDataManager: LoginAPIDataManagerInputProtocol
{
    init() {}
    
    func loginWith(usermane username: String, company: String, completion: (APIClientResult<UserData, APIClientError>) -> Void) {
        /*let delayInSeconds: UInt64 = 1
        let popTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(delayInSeconds * NSEC_PER_SEC))
        dispatch_after(popTime, dispatch_get_main_queue()) {() -> Void in
            completion((Int)(arc4random() % 2) != 0)
        }*/
        
        let clientAPI = APIClient.userAPIClient()
        clientAPI.login(username: username, company: company) {(completion($0))}
    }
}