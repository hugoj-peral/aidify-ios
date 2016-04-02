//
//  File.swift
//  aidify
//
//  Created by salazar on 31/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//


import Foundation
import UIKit

class PairingView: AIDViewController, PairingViewProtocol
{
    
    
    @IBOutlet weak var pairingImage: UIImageView!
    @IBOutlet weak var pairingTitleLabel: UILabel!
    @IBOutlet weak var pairingSubtitleLabel: UILabel!
    @IBOutlet weak var pairingPrimaryButton: UIButton!
    @IBOutlet weak var pairingSecondaryButton: UIButton!
    
    var presenter: PairingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.initialLookNFeel()
    }
    
    func loadPairingRequestLookNFeel() {
        self.view.backgroundColor = AIDColor.Blue.color()
        self.statusBarColor = AIDColor.DarkBlue.color()
        pairingPrimaryButton.hidden = false
        pairingSecondaryButton.hidden = false
        pairingTitleLabel.text = "LOCATION"
        pairingSubtitleLabel.text = "ai{d}fy needs access to your location in order to know if you are at your desk... and to bring you delicious donuts!"
        pairingPrimaryButton.setTitle("Enable Location", forState: .Normal)
        pairingSecondaryButton.setTitle("not now", forState: .Normal)
    }
    
    func loadPairingActionLookNFeel() {
        pairingPrimaryButton.hidden = true
        pairingSecondaryButton.hidden = true
        pairingTitleLabel.text = "PAIRING BEACON"
        pairingSubtitleLabel.text = "pair your phone with the beacon at your desk"
    }
    
    func loadPairingSuccessfulLookNFeel(nearableId: String) {
        pairingTitleLabel.text = "SUCCESSFUL PAIRED"
        pairingSubtitleLabel.text = "ID: \(nearableId)"
        UIView.animateWithDuration(0.4) { () -> Void in
            self.view.backgroundColor = AIDColor.Green.color()
            self.statusBarColor = AIDColor.DarkGreen.color()
        }
    }
    
    func loadPairingFailureLookNFeel() {
        pairingPrimaryButton.hidden = false
        pairingSecondaryButton.hidden = false
        pairingTitleLabel.text = "PAIRING FAILED"
        pairingSubtitleLabel.text = "impossible to pair with your beacon desk. Are you in range?"
        pairingPrimaryButton.setTitle("Pair Again", forState: .Normal)
        pairingSecondaryButton.setTitle("or skip step", forState: .Normal)
        UIView.animateWithDuration(0.4) { () -> Void in
            self.view.backgroundColor = AIDColor.Pink.color()
            self.statusBarColor = AIDColor.DarkPink.color()
        }
    }
    
    @IBAction func primaryButtonDidPressed(sender: AnyObject) {
        presenter?.primaryAction()
    }
    @IBAction func secondaryButtonDidPressed(sender: AnyObject) {
        presenter?.secondaryAction()
    }
}