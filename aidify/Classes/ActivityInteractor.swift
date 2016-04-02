//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation

class ActivityInteractor: ActivityInteractorInputProtocol
{
    weak var presenter: ActivityInteractorOutputProtocol?
    var APIDataManager: ActivityAPIDataManagerInputProtocol?
    var localDatamanager: ActivityLocalDataManagerInputProtocol?
    
    init() {}
}