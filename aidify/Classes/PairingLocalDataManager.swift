//
//  File.swift
//  aidify
//
//  Created by salazar on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

enum PairingResult {
    case Success(String)
    case Failure(NSError)
}

class PairingLocalDataManager: NSObject, PairingLocalDataManagerInputProtocol,ESTNearableManagerDelegate
{
    private let nearableManager: ESTNearableManager
    private var findClosestClosure: ((PairingResult)->())?
    private var timer: NSTimer?
    
    override init() {
        nearableManager = ESTNearableManager()
        super.init()
        nearableManager.delegate = self
    }
    
    func findClosestNearable(closure: ((PairingResult)->())?) {
        findClosestClosure = closure
        nearableManager.startRangingForType(.All)
        timer = NSTimer.scheduledTimerWithTimeInterval(20.0, target: self, selector: "rangingTimeout", userInfo: nil, repeats: false)
    }
    
    func rangingTimeout() {
        nearableManager.stopRanging()
        timer = nil
        
        findClosestClosure?(.Failure(NSError(domain: "aidify", code: 408, userInfo: nil)))
        findClosestClosure = nil
    }
    
    func nearableManager(manager: ESTNearableManager, didRangeNearables nearables: [ESTNearable], withType type: ESTNearableType) {
        
        let immediateNearables = nearables.filter({$0.zone() == .Immediate})
        
        if (immediateNearables.count > 0) {
            timer?.invalidate()
            timer = nil
            
            manager.stopRangingForType(type)
            
            let closestNearable = immediateNearables.sort({$0.rssi > $1.rssi}).first!
            findClosestClosure?(.Success(closestNearable.identifier))
            findClosestClosure = nil
        }
    }
    
    func nearableManager(manager: ESTNearableManager, rangingFailedWithError error: NSError) {
        findClosestClosure?(.Failure(error))
        findClosestClosure = nil
    }
}
