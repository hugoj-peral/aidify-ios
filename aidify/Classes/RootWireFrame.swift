//
//  RootWireFrame.swift
//  aidify
//
//  Created by Hugo Peral on 29/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

protocol RootWireFrameProtocol: class {
    
    var window: UIWindow? { get set }
    
    func presentLoginModule()
    func presentProfileModule()
}

class RootWireFrame: RootWireFrameProtocol {
    
    weak var window: UIWindow?
    
    func presentLoginModule() {
        guard let window = window else { fatalError("Error: no window") }
        LoginWireFrame.presentLoginModule(fromWindow: window, rootWireFrame:self)
    }
    
    func presentProfileModule() {
        guard let window = window else { fatalError("Error: no window") }
        ProfileWireFrame.presentProfileModule(fromWindow: window, rootWireFrame: self)
    }
}
