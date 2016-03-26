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
    
    func githubLoginWith(usermane username: String, password: String) {
        let clientAPI = APIClient.githubAPIClient()
        clientAPI.authorizationWithName(username, password: password, completion: { (result: APIClientResult<AuthorizationGithub, APIClientError>) -> Void in
            print(result)
        })
    }
}