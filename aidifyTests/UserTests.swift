//
//  UserTests.swift
//  aidify
//
//  Created by Hugo Peral on 30/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import XCTest
@testable import aidify

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBeaconPaired() {
        let user = User(username: "Doe", company: "Without")
        XCTAssertFalse(user.hasBeaconPaired())
        user.beaconId = "beaconId"
        XCTAssertTrue(user.hasBeaconPaired())
    }
}
