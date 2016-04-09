//
//  SettingsView.swift
//  aidify
//
//  Created by Hugo Peral on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

class SettingsView: AIDViewController, SettingsViewProtocol
{
    var presenter: SettingsPresenterProtocol?
    @IBOutlet weak var beaconSwitch: UISwitch!
    @IBOutlet weak var beaconLabel: UILabel!
    @IBOutlet weak var logOutButton: AIDButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AIDColor.Yellow.color()
        logOutButton.backgroundColor = AIDColor.Pink.color()
        logOutButton.highlightedColor = AIDColor.DarkPink.color()
        title = "Settings"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarColor = AIDColor.DarkYellow.color()
        presenter?.requestNearableIdentifier()
    }
    
    func setNearableIdentifier(identifier: String?) {
        
        if let identifier = identifier {
            self.beaconLabel.text = identifier
            self.beaconSwitch.on = true
        } else {
            self.beaconLabel.text = "pair beacon"
            self.beaconSwitch.on = false
        }
    }
}

extension SettingsView {
    @IBAction func logOut(sender: AnyObject) {
        presenter?.logOut()
    }
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        if sender.on {
            presenter?.requestPairing()
        } else {
            self.beaconLabel.text = "pair beacon"
            presenter?.requestUnpairing()
        }
    }
}
