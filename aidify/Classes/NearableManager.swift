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
    
    private var simulator: ESTSimulatedNearableManager?
    
    var userManager: UserManager?
    var identifier: String?
    
    private override init() {
        super.init()
        nearableManager.delegate = self
        simulator = ESTSimulatedNearableManager(delegate: self)
        simulator?.addNearableToSimulation("0a1b2c3d4e5f6a7b", withType: .All, zone: .Far, rssi: -20)
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "simulateRange", userInfo: nil, repeats: false)
    }
    
    func simulateRange() {
        simulator?.simulateDidExitRegionForNearable(simulator?.nearables.firstObject as! ESTNearable)
        //simulator?.simulateDidEnterRegionForNearable(simulator?.nearables.firstObject as! ESTNearable)
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
    
    func nearableManager(manager: ESTNearableManager, didRangeNearable nearable: ESTNearable) {
    }
    
    private func updateUserLocation(location: UserLocation) {
        guard let user = userManager?.currentUser else {
            return
        }

        user.location = location.rawValue
        let clientAPI = APIClient.userAPIClient()
        
        if let userToUpdate = user.convertToUserData() {
            clientAPI.update(userToUpdate) { _ in }
        }
    }
}