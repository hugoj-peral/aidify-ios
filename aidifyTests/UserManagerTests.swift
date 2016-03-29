//
//  aidifyTests.swift
//  aidifyTests
//
//  Created by Hugo Peral on 19/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import XCTest
@testable import aidify

class UserManagerTests: XCTestCase {
    
    let userManager = UserManager()
    
    override func setUp() {
        super.setUp()
        
        userManager.storage = NSUserDefaults()
    }
    
    override func tearDown() {
        userManager.storage.removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)
        userManager.storage.synchronize()
        super.tearDown()
    }
    
    func testIsLogged() {
        XCTAssertFalse(userManager.isAnyUserLogged())
    }
    
    func testSave() {
        XCTAssertNil(userManager.currentUser)
        let user = User(username: "Doe", company: "Without")
        userManager.save(user: user)
        XCTAssertNotNil(userManager.currentUser)
        let recovered = userManager.currentUser
        XCTAssertTrue(recovered?.username == "Doe" && recovered?.company == "Without")
    }
    
    func testLogOut() {
        XCTAssertNil(userManager.currentUser)
        let user = User(username: "Doe", company: "Without")
        userManager.save(user: user)
        XCTAssertNotNil(userManager.currentUser)
        userManager.logOut()
        XCTAssertNil(userManager.currentUser)
    }
}
