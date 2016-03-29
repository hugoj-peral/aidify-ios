//
//  User.swift
//  aidify
//
//  Created by Hugo Peral on 28/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    
    var username: String
    var company: String
    
    init(username: String, company: String) {
        self.username = username
        self.company = company
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(username, forKey: "username")
        aCoder.encodeObject(company, forKey: "company")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.username = aDecoder.decodeObjectForKey("username") as! String
        self.company = aDecoder.decodeObjectForKey("company") as! String
    }
}
