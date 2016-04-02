//
//  File.swift
//  aidify
//
//  Created by salazar on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//


import Foundation

class PairingPresenter: PairingPresenterProtocol, PairingInteractorOutputProtocol
{
    weak var view: PairingViewProtocol?
    var interactor: PairingInteractorInputProtocol?
    var wireFrame: PairingWireFrameProtocol?
    
    init() {}
    
    func initialLookNFeel() {
        view?.loadPairingRequestLookNFeel()
    }
    
    func primaryAction() {
        view?.loadPairingActionLookNFeel()
        interactor?.pairClosestNearable()
    }
    
    func secondaryAction() {
        wireFrame?.dismissView(view)
    }
    
    func pairingSuccessful(nearableId: String) {
        view?.loadPairingSuccessfulLookNFeel(nearableId)
        
        let delayInSeconds = 3.0
        let dismissTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(dismissTime, dispatch_get_main_queue()) {[weak self]() -> Void in
            guard let strongSelf = self else { return }
            strongSelf.wireFrame?.dismissView(strongSelf.view)
        }
    }
    
    func pairingFailure() {
        view?.loadPairingFailureLookNFeel()
    }
    
}