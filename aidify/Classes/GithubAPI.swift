//
//  GithubAPI.swift
//  aidify
//
//  Created by Hugo Peral on 25/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

enum GithubAPI {
    case Authorization(username: String, password: String)
}

extension GithubAPI: Resource {
    
    var clientId: String { return "XXXXXXXXXX" }
    var clientSecret: String { return "XXXXXXXXXX" }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "authorizations/clients/\(clientId)"
    }
    
    var parameters: [String: AnyObject] {
        return ["client_secret": clientSecret,
                "scopes": ["repo:status", "public_repo", "user:email", "read:org"]]
    }
    
    var auth: Auth {
        switch self {
        case let .Authorization(username, password):
            return Auth.Basic(user: username, pass: password)
        }
    }
}

extension NSURL {
    class func githubURL() -> NSURL {
        return NSURL(string: "https://api.github.com")!
    }
}

extension APIClient {
    class func githubAPIClient() -> APIClient {
        return APIClient(baseURL: NSURL.githubURL())
    }
    
    func authorizationWithName(username: String, password: String, completion: (APIClientResult<AuthorizationGithub, APIClientError>) -> Void) {
        object(GithubAPI.Authorization(username: username, password: password)) { (result: APIClientResult<AuthorizationGithub, APIClientError>) -> Void in
            completion(result)
        }
    }
}

