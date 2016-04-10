//
//  File.swift
//  aidify
//
//  Created by salazar on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import CoreLocation

enum PairingResult {
    case Success(String)
    case Failure(NSError)
}

class PairingLocalDataManager: NSObject, PairingLocalDataManagerInputProtocol, ESTNearableManagerDelegate
{
    
    var userManager: UserManagerProtocol?
    
    private let nearableManager: ESTNearableManager
    private var findClosestClosure: ((PairingResult)->())?
    private var requestBGClosure: ((Bool)->())?
    private var timer: NSTimer?
    private var locationManager: CLLocationManager?
    
    private var simulator: ESTSimulatedNearableManager?
    
    override init() {
        nearableManager = ESTNearableManager()
        super.init()
        nearableManager.delegate = self
        simulator = ESTSimulatedNearableManager(delegate: self)
    }
    
    func requestBackgroundAccess(closure: ((Bool)->())?) {
        requestBGClosure = closure
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestAlwaysAuthorization()
    }
    
    func findClosestNearable(closure: ((PairingResult)->())?) {
        findClosestClosure = closure
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.nearableManager.startRangingForType(.All)
        }
        
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(20.0, target: self, selector: "rangingTimeout", userInfo: nil, repeats: false)
        
        
        
        simulator?.addNearableToSimulation("0a1b2c3d4e5f6a7b", withType: .All, zone: .Far, rssi: -20)
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "simulateRange", userInfo: nil, repeats: false)
    }
    
    func simulateRange() {
        simulator?.simulateZone(.Immediate, forNearable: "0a1b2c3d4e5f6a7b")
        self.nearableManager(nearableManager, didRangeNearable: simulator?.nearables.firstObject as! ESTNearable)
    }
    
    func rangingTimeout() {
        nearableManager.stopRanging()
        timer = nil
        
        findClosestClosure?(.Failure(NSError(domain: "aidify", code: 408, userInfo: nil)))
        findClosestClosure = nil
    }
    
    func nearableManager(manager: ESTNearableManager, didRangeNearable nearable: ESTNearable) {
        
        if nearable.zone() != .Immediate {
            return
        }
        
        timer?.invalidate()
        timer = nil
        
        manager.stopRanging()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.nearableFound(nearable)
        }
    }
    
    func nearableManager(manager: ESTNearableManager, didRangeNearables nearables: [ESTNearable], withType type: ESTNearableType) {
        
        if nearables.count == 0 {
            return
        }
        
        let immediateNearables = nearables.filter({$0.zone() == .Immediate})
        
        if (immediateNearables.count > 0) {
            timer?.invalidate()
            timer = nil
            
            manager.stopRanging()
            
            let closestNearable = immediateNearables.sort({$0.rssi > $1.rssi}).first!
            dispatch_async(dispatch_get_main_queue()) {
                self.nearableFound(closestNearable)
            }
        }
    }
    
    private func nearableFound(nearableDevice: ESTNearable) {
        self.userManager?.updateBeacon(nearableDevice.identifier)
        self.findClosestClosure?(.Success(nearableDevice.identifier))
        self.findClosestClosure = nil
    }
}

extension PairingLocalDataManager: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .NotDetermined {
            return
        }
        
        requestBGClosure?(status == .AuthorizedAlways)
        locationManager = nil
        requestBGClosure = nil
    }
}
