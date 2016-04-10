//
//  aidify
//
//  Created by salazar on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
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