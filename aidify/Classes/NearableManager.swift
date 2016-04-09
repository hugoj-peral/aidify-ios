//
//  NearableManager.swift
//  aidify
//
//  Created by salazar on 2/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

class NearableManager: NSObject {
    
    static let sharedInstance = NearableManager()
    private let nearableManager = ESTNearableManager()
    
    var user: UserData?
    var identifier: String?
    
    private override init() {
        super.init()
        nearableManager.delegate = self
    }
    
    func startMonitoring(identifier: String) {
        self.identifier = identifier
        nearableManager.startMonitoringForIdentifier(identifier)
    }
    
    func stopMonitoring() {
        guard let identifier = identifier else {
            return
        }
        nearableManager.stopMonitoringForIdentifier(identifier)
        self.identifier = nil
    }
}

extension NearableManager: ESTNearableManagerDelegate {
    
    func nearableManager(manager: ESTNearableManager, didEnterIdentifierRegion identifier: String) {
        updateUserLocation(.Working)
    }
    
    func nearableManager(manager: ESTNearableManager, didExitIdentifierRegion identifier: String) {
        updateUserLocation(.Out)
    }
    
    private func updateUserLocation(location: UserLocation) {
        guard var user = user else {
            return
        }

        user.location = location
        
        let clientAPI = APIClient.userAPIClient()
        clientAPI.update(user) { _ in }
    }
}