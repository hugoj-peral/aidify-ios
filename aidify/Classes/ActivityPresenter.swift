//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation

class ActivityPresenter: ActivityPresenterProtocol, ActivityInteractorOutputProtocol
{
    weak var view: ActivityViewProtocol?
    var interactor: ActivityInteractorInputProtocol?
    var wireFrame: ActivityWireFrameProtocol?
    
    var activities: [UserActivity] = []
    
    init() {}
    
    func dataRequest() {
        view?.setData(activities)
    }
    
    func setActivities(activities: [UserActivity]) {
        self.activities = activities
    }
}