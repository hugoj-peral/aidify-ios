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
    
    @IBOutlet weak var pairingLeftSignal: UIImageView!
    @IBOutlet weak var pairingRightSignal: UIImageView!
    @IBOutlet weak var pairingBase: UIImageView!
    
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadBouncingAnimation()
    }
    
    private func loadBouncingAnimation() {
        let moveUpAnimation = CABasicAnimation(keyPath: "position.y")
        moveUpAnimation.fromValue = pairingImage.layer.position.y
        moveUpAnimation.toValue = pairingImage.layer.position.y - 15
        moveUpAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        moveUpAnimation.beginTime = 0
        moveUpAnimation.duration = 0.3
        
        let moveDownAnimation = CASpringAnimation(keyPath: "position.y")
        moveDownAnimation.fromValue = moveUpAnimation.toValue
        moveDownAnimation.toValue = pairingImage.layer.position.y + 6
        moveDownAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        moveDownAnimation.damping = 9.5
        moveDownAnimation.beginTime = moveUpAnimation.beginTime + moveUpAnimation.duration
        moveDownAnimation.duration = moveDownAnimation.settlingDuration
        
        let moveUpBackAnimation = CABasicAnimation(keyPath: "position.y")
        moveUpBackAnimation.fromValue = moveDownAnimation.toValue
        moveUpBackAnimation.toValue = pairingImage.layer.position.y
        moveUpBackAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        moveUpBackAnimation.beginTime = moveDownAnimation.beginTime + moveDownAnimation.duration
        moveUpBackAnimation.duration = 0.4
        
        let animationGroup = CAAnimationGroup()
        animationGroup.beginTime = CACurrentMediaTime() + 0.5
        animationGroup.duration = moveUpAnimation.duration + moveDownAnimation.duration + moveUpBackAnimation.duration
        animationGroup.fillMode = kCAFillModeBackwards
        animationGroup.repeatCount = .infinity
        animationGroup.speed = 1.1
        animationGroup.animations = [moveUpAnimation, moveDownAnimation, moveUpBackAnimation]
        pairingImage.layer.addAnimation(animationGroup, forKey: "pairingInit")
    }
    
    private func removeAllAnimations() {
        pairingImage.layer.removeAllAnimations()
        pairingLeftSignal.layer.removeAllAnimations()
        pairingRightSignal.layer.removeAllAnimations()
    }
    
    func loadPairingRequestLookNFeel() {
        self.view.backgroundColor = AIDColor.Blue.color()
        self.statusBarColor = AIDColor.DarkBlue.color()
        pairingImage.image = UIImage(named: "location")
        pairingLeftSignal.hidden = true
        pairingRightSignal.hidden = true
        pairingBase.hidden = false
        pairingPrimaryButton.hidden = false
        pairingSecondaryButton.hidden = false
        pairingTitleLabel.text = "LOCATION"
        pairingSubtitleLabel.text = "ai{d}fy needs access to your location in order to know if you are at your desk... and to bring you delicious donuts!"
        pairingPrimaryButton.setTitle("Enable Location", forState: .Normal)
        pairingSecondaryButton.setTitle("not now", forState: .Normal)
    }
    
    func loadPairingActionLookNFeel() {
        removeAllAnimations()
        pairingImage.image = UIImage(named: "location")
        pairingLeftSignal.hidden = false
        pairingRightSignal.hidden = false
        pairingBase.hidden = true
        pairingPrimaryButton.hidden = true
        pairingSecondaryButton.hidden = true
        pairingTitleLabel.text = "PAIRING BEACON"
        pairingSubtitleLabel.text = "pair your phone with the beacon at your desk"
        loadPairingAnimation()
    }
    
    private func loadPairingAnimation() {
        let expandLeftAnimation = CABasicAnimation(keyPath: "position.x")
        expandLeftAnimation.fromValue = pairingLeftSignal.layer.position.x
        expandLeftAnimation.toValue = pairingLeftSignal.layer.position.x - 60
        expandLeftAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        expandLeftAnimation.fillMode = kCAFillModeForwards
        expandLeftAnimation.beginTime = 0
        expandLeftAnimation.duration = 1
        
        let expandRightAnimation = CABasicAnimation(keyPath: "position.x")
        expandRightAnimation.fromValue = pairingRightSignal.layer.position.x
        expandRightAnimation.toValue = pairingRightSignal.layer.position.x + 60
        expandRightAnimation.fillMode = expandLeftAnimation.fillMode
        expandRightAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        expandRightAnimation.beginTime = expandLeftAnimation.beginTime
        expandRightAnimation.duration = expandLeftAnimation.duration
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        opacityAnimation.beginTime = 0.4
        opacityAnimation.duration = 0.6
        
        let animationLeftGroup = CAAnimationGroup()
        animationLeftGroup.beginTime = CACurrentMediaTime() + 0.5
        animationLeftGroup.duration = max(expandLeftAnimation.duration, opacityAnimation.duration) + 0.75
        animationLeftGroup.fillMode = kCAFillModeBackwards
        animationLeftGroup.repeatCount = .infinity
        animationLeftGroup.speed = 1.0
        animationLeftGroup.animations = [expandLeftAnimation, opacityAnimation]
        
        let animationRightGroup = CAAnimationGroup()
        animationRightGroup.beginTime = animationLeftGroup.beginTime
        animationRightGroup.duration = animationLeftGroup.duration
        animationRightGroup.fillMode = animationLeftGroup.fillMode
        animationRightGroup.repeatCount = .infinity
        animationRightGroup.speed = animationLeftGroup.speed
        animationRightGroup.animations = [expandRightAnimation, opacityAnimation]
        
        pairingLeftSignal.layer.addAnimation(animationLeftGroup, forKey: "pairingLeftSignal")
        pairingRightSignal.layer.addAnimation(animationRightGroup, forKey: "pairingRightSignal")
    }
    
    func loadPairingSuccessfulLookNFeel(nearableId: String) {
        removeAllAnimations()
        pairingImage.image = UIImage(named: "locationSuccess")
        pairingTitleLabel.text = "SUCCESSFUL PAIRED"
        pairingSubtitleLabel.text = "ID: \(nearableId)"
        pairingLeftSignal.hidden = true
        pairingRightSignal.hidden = true
        pairingBase.hidden = false
        pairingPrimaryButton.hidden = true
        pairingSecondaryButton.hidden = true
        UIView.animateWithDuration(0.4) { () -> Void in
            self.view.backgroundColor = AIDColor.Green.color()
            self.statusBarColor = AIDColor.DarkGreen.color()
        }
    }
    
    func loadPairingFailureLookNFeel() {
        removeAllAnimations()
        pairingImage.image = UIImage(named: "locationFailure")
        pairingPrimaryButton.hidden = false
        pairingSecondaryButton.hidden = false
        pairingLeftSignal.hidden = true
        pairingRightSignal.hidden = true
        pairingBase.hidden = false
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