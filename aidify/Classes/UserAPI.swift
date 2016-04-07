//
//  UserAPI.swift
//  aidify
//
//  Created by salazar on 3/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

enum UserAPI {
    case Login(username: String, company: String)
    case Get(userID: Int)
}

extension UserAPI: Resource {
    
    var method: Method {
        switch self {
        case .Login:
            return .POST
        case .Get:
            return .GET
        }
    }
    
    var path: String {
        return "user"
    }
    
    var pathParameters: [String] {
        switch self {
        case let .Get(userID):
            return [String(userID)]
        default:
            return []
        }
    }
    
    var parameters: [String: AnyObject] {
        switch self {
        case let .Login(username, company):
            return ["username" : username, "company" : company]
        case .Get:
            return [String: AnyObject]()
        }
    }
    
    var auth: Auth {
        return .None
    }
}

extension NSURL {
    class func userURL() -> NSURL {
        return NSURL(string:"https://apigateway-aidifycloud.herokuapp.com")!
    }
}

extension APIClient {
    class func userAPIClient() -> APIClient {
        return APIClient(baseURL: NSURL.userURL())
    }
    
    func userWithID(userID: Int, completion: (APIClientResult<UserData, APIClientError>) -> Void) {
        object(UserAPI.Get(userID: userID)) { (completion($0)) }
    }
    
    func login(username username: String, company: String, completion: (APIClientResult<UserData, APIClientError>) -> Void) {
        object(UserAPI.Login(username: username, company: company)) { (completion($0)) }
    }
}