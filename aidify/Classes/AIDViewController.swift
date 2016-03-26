//
//  AIDViewController.swift
//  aidify
//
//  Created by Hugo Peral on 26/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

class AIDViewController: UIViewController {

    lazy var statusBarView: UIView = {
        let statusBarView = UIView(frame: self.statusBarFrame())
        statusBarView.backgroundColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 0.3)
        return statusBarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStatusBarView()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func statusBarFrame() -> CGRect {
        return UIApplication.sharedApplication().statusBarFrame
    }
    
    func addStatusBarView() {
        view.addSubview(statusBarView)
    }
}
