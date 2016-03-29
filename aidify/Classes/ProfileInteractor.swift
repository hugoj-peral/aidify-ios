//
//  ProfileInteractor.swift
//  aidify
//
//  Created by Hugo Peral on 29/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

class ProfileInteractor: ProfileInteractorInputProtocol
{
    weak var presenter: ProfileInteractorOutputProtocol?
    var APIDataManager: ProfileAPIDataManagerInputProtocol?
    var localDatamanager: ProfileLocalDataManagerInputProtocol?
    
    init() {}
}