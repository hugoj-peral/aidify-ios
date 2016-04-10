//
//  aidify
//
//  Created by salazar on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//


import Foundation

class ActivityInteractor: ActivityInteractorInputProtocol
{
    weak var presenter: ActivityInteractorOutputProtocol?
    var APIDataManager: ActivityAPIDataManagerInputProtocol?
    var localDatamanager: ActivityLocalDataManagerInputProtocol?
    
    init() {}
}