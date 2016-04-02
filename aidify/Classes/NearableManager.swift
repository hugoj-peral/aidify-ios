//
//  NearableManager.swift
//  aidify
//
//  Created by salazar on 2/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

protocol NearableManagerDelegate: class {
    
    //func showroomManager(showroomManager: ShowroomManager, didDetectPickupForProduct product: Product)
    
    //`func showroomManager(showroomManager: ShowroomManager, didDetectPutdownForProduct product: Product)
    
}

class NearableManager: NSObject, ESTNearableManagerDelegate {
    
    weak var delegate: NearableManagerDelegate?
    
    private let nearableManager = ESTNearableManager()
    
    override init() {
        super.init()
        nearableManager.delegate = self
    }
    
    
    

    /*private let products: [NearableID: Product]
    
    private let triggerManager = ESTTriggerManager()
    private var triggers = [ESTTrigger]()
    
    init(products: [NearableID: Product]) {
        self.products = products
        
        super.init()
        
        self.triggerManager.delegate = self
        
        for nearableID in products.keys {
            let motionRule = ESTMotionRule.motionStateEquals(true, forNearableIdentifier: nearableID.nearableIDString)
            let motionTrigger = ESTTrigger(rules: [motionRule], identifier: nearableID.nearableIDString)
            self.triggers.append(motionTrigger)
        }
    }
    
    func startUpdates() {
        for trigger in self.triggers {
            self.triggerManager.startMonitoringForTrigger(trigger)
        }
    }
    
    func stoptUpdates() {
        for trigger in self.triggers {
            self.triggerManager.stopMonitoringForTriggerWithIdentifier(trigger.identifier)
        }
    }
    
    func triggerManager(manager: ESTTriggerManager, triggerChangedState trigger: ESTTrigger) {
        if let nearableID = NearableID(nearableIDString: trigger.identifier), let product = self.products[nearableID] {
            if trigger.state == true {
                self.delegate?.showroomManager(self, didDetectPickupForProduct: product)
            } else {
                self.delegate?.showroomManager(self, didDetectPutdownForProduct: product)
            }
        }
    }*/
    
}