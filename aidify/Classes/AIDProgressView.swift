//
//  AIDProgressView.swift
//  aidify
//
//  Created by Hugo Peral on 26/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit


class AIDProgressView: UIView {
    
    @IBInspectable var progressTint: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8) {
        didSet {
            progressLayer.backgroundColor = progressTint.CGColor
        }
    }
    @IBInspectable var trackTint: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) {
        didSet {
            trackLayer.backgroundColor = trackTint.CGColor
        }
    }
    
    @IBInspectable var progress: CGFloat = 0.0 {
        didSet {
            if (progress != oldValue) {
                // progress values go from 0.0 to 1.0
                progress = min(1.0, fabs(progress))
                setNeedsLayout()
            }
        }
    }
    
    lazy var progressLayer: CALayer = {
       let layer = CALayer()
        layer.frame = CGRectMake(0, 0, 0, self.layer.frame.size.height)
        return layer
    }()
    
    lazy var trackLayer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRectMake(0, 0, 0, self.layer.frame.size.height)
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
        
        self.setupView()
    }
    
    override class func layerClass() -> AnyClass {
        return CALayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = progressLayer.frame
        frame.size.width = CGRectGetWidth(bounds) * progress
        progressLayer.frame = frame
        
        let x = CGRectGetWidth(progressLayer.frame)
        let width = CGRectGetWidth(bounds) - x
        frame = bounds
        frame.origin.x = x
        frame.size.width = width
        trackLayer.frame = frame
        
    }
    
    func setupView() {
        let layer: CALayer = self.layer
        layer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.backgroundColor = progressTint.CGColor
        trackLayer.backgroundColor = trackTint.CGColor
        layer.addSublayer(progressLayer)
        layer.addSublayer(trackLayer)
    }
    
    func simulateProgress() {
        let delayInSeconds: UInt64 = 1
        let popTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(delayInSeconds * NSEC_PER_SEC))
        dispatch_after(popTime, dispatch_get_main_queue()) { [weak self] () -> Void in
            guard let strongSelf = self else { return }
            let increment = (CGFloat)(arc4random() % 3) / 10.0 + 0.1
            let nextProgress = strongSelf.progress + increment
            strongSelf.progress = nextProgress
            if (strongSelf.progress < 1.0) {
                strongSelf.simulateProgress()
            }
        }
    }
    
    func reset() {
        var frame = progressLayer.frame
        frame.size.width = 0.0
        progressLayer.frame = frame
        
        let width = CGRectGetWidth(bounds)
        frame = trackLayer.frame
        frame.origin.x = 0
        frame.size.width = width
        trackLayer.frame = frame
        progress = 0.0;
    }
}
