//
//  AIDButton.swift
//  aidify
//
//  Created by Hugo Peral on 1/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

@IBDesignable class AIDButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setupShadow()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSizeZero {
        didSet {
            setupShadow()
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            setupShadow()
        }
    }
    
    @IBInspectable var highlightedColor: UIColor?
    
    override var highlighted: Bool {
        willSet {
            if let backgroundColor = backgroundColor where highlighted == false {
                mainColor = backgroundColor
            }
        }
        
        didSet {
            if (highlighted) {
                if let highlightedColor = highlightedColor {
                    backgroundColor = highlightedColor
                }
            } else {
                if let mainColor = mainColor {
                    backgroundColor = mainColor
                }
            }
        }
    }
    
    private var mainColor: UIColor?
    
    func setupShadow() {
        layer.cornerRadius = cornerRadius
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor?.CGColor
        layer.shadowRadius = cornerRadius
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.setNeedsDisplay()
    }
}
