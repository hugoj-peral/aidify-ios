//
//  UserManager.swift
//  aidify
//
//  Created by Hugo Peral on 28/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

protocol UserManagerProtocol: class {
    
    var currentUser: User? { get }
    
    func save(user user: User)
    func logOut()
    func isAnyUserLogged() -> Bool
    func updateBeacon(identifier: String?)
}

final class UserManager: UserManagerProtocol {
    
    var currentUser: User? {
        get {
            guard let encodedUser = storage.objectForKey(K.UserDeafultsKey.User) else { return nil }
            return NSKeyedUnarchiver.unarchiveObjectWithData(encodedUser as! NSData) as? User
        }
    }
    
    lazy var storage: NSUserDefaults = {
        return NSUserDefaults.standardUserDefaults()
    }()
    
    func save(user user: User) {
        let encodedUser = NSKeyedArchiver.archivedDataWithRootObject(user)
        storage.setObject(encodedUser, forKey: K.UserDeafultsKey.User)
        storage.synchronize()
    }
    
    func updateBeacon(identifier: String?) {
        guard let user = currentUser else {
            return
        }
        
        user.beaconId = identifier
        save(user: user)
    }
    
    func logOut() {
        if(isAnyUserLogged()) {
            storage.removeObjectForKey(K.UserDeafultsKey.User)
            storage.synchronize()
        }
    }
    
    func isAnyUserLogged() -> Bool {
        if let _ = currentUser {
            return true
        } else {
            return false
        }
    }
}
