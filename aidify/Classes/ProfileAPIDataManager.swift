//
//  ProfileAPIDataManager.swift
//  aidify
//
//  Created by Hugo Peral on 29/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class ProfileAPIDataManager: ProfileAPIDataManagerInputProtocol
{
    init() {}
    
    func getProfile(userID userID: Int, completion: (APIClientResult<UserData, APIClientError>) -> Void) {
        let clientAPI = APIClient.userAPIClient()
        clientAPI.userWithID(userID) {(completion($0))}
    }
}