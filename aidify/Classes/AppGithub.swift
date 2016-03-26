//
//  AppGithub.swift
//  aidify
//
//  Created by Hugo Peral on 26/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

struct AppGithub {
    let name: String
    let url: String
    let clientId: String
}

extension AppGithub: JSONDecodable {
    init?(dictionary: JSONDictionary) {
        guard let name = dictionary["name"] as? String,
            url = dictionary["url"] as? String,
            clientId = dictionary["client_id"] as? String else {
                return nil
        }
        
        self.name = name
        self.url = url
        self.clientId = clientId
    }
}
