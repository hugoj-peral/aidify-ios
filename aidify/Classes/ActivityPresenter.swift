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
    
    init() {}
}