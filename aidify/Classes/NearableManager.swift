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
    
    var userManager: UserManager?
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
        updateUserLocation(.Out)
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
    
    func nearableManager(manager: ESTNearableManager, didRangeNearable nearable: ESTNearable) {
    }
    
    private func updateUserLocation(location: UserLocation) {
        
        userManager?.updateLocation(location)
        
        guard let user = userManager?.currentUser else {
            return
        }
        
        let clientAPI = APIClient.userAPIClient()
        
        if let userToUpdate = user.convertToUserData() {
            clientAPI.update(userToUpdate) { _ in }
        }
    }
}