//
//  File.swift
//  aidify
//
//  Created by salazar on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//


import Foundation

class PairingInteractor: PairingInteractorInputProtocol
{
    weak var presenter: PairingInteractorOutputProtocol?
    var APIDataManager: PairingAPIDataManagerInputProtocol?
    var localDatamanager: PairingLocalDataManagerInputProtocol?
    
    init() {}
    
    private func pairClosestNearable() {
        localDatamanager?.findClosestNearable({
            switch $0 {
            case let .Success(identifier):
                NearableManager.sharedInstance.startMonitoring(identifier)
                self.presenter?.pairingSuccessful(identifier)
            case .Failure(_):
                self.presenter?.pairingFailure()
            }
        })
    }
    
    func requestBackgroundAccess() {
        localDatamanager?.requestBackgroundAccess( {
            if $0 {
                self.presenter?.requestBackgroundSuccess()
                self.pairClosestNearable()
            } else {
                self.presenter?.requestBackgroundFail()
            }
        })
    }
}