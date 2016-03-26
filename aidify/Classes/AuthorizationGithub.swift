//
//  AuthorizationGithub.swift
//  aidify
//
//  Created by Hugo Peral on 25/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

struct AuthorizationGithub {
    
    let id: Int
    let url: String
    let token: String
    let hashedToken: String
    let tokenLastEight: String
    let scopes: [String]
    let app: AppGithub?
}

extension AuthorizationGithub: JSONDecodable {
    init?(dictionary: JSONDictionary) {
        guard let id = dictionary["id"] as? Int,
            token = dictionary["token"] as? String,
            hashedToken = dictionary["hashed_token"] as? String,
            tokenLastEight = dictionary["token_last_eight"] as? String,
            app = dictionary["app"] as? JSONDictionary else {
                return nil
        }
        
        self.id = id
        self.token = token
        self.hashedToken = hashedToken
        self.tokenLastEight = tokenLastEight
        self.url = dictionary["url"] as? String ?? ""
        self.scopes = dictionary["scopes"] as? [String] ?? []
        self.app = decode(app)
    }
}
