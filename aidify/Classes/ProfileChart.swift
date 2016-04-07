//
//  ProfileChart.swift
//  aidify
//
//  Created by salazar on 6/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation


import UIKit


public protocol PiechartDelegate {
    func setSubtitle(total: CGFloat, slice: Piechart.Slice) -> String
    func setInfo(total: CGFloat, slice: Piechart.Slice) -> String
}


/**
 * Piechart
 */
public class Piechart: UIControl {
    
    /**
     * Slice
     */
    public struct Slice {
        public var color: UIColor!
        public var value: CGFloat!
    }
    
    /*
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var infoLabel: UILabel!
*/
    
    private var total: CGFloat!
    
    /*
    public var delegate: PiechartDelegate?
    
    public var title: String = "title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var subtitle: String = "subtitle" {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    public var info: String = "info" {
        didSet {
            infoLabel.text = info
        }
    }
    */
    
    public var slices: [Slice] = [] {
        didSet {
            total = 0
            for slice in slices {
                total = slice.value + total
            }
        }
    }
    
    
    
    /**
     * methods
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        /*
        self.addTarget(self, action: "click", forControlEvents: .TouchUpInside)
        
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        titleLabel.textAlignment = .Center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        subtitleLabel.textColor = UIColor.grayColor()
        subtitleLabel.textAlignment = .Center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subtitleLabel)
        
        infoLabel = UILabel()
        infoLabel.text = subtitle
        infoLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        infoLabel.textColor = UIColor.grayColor()
        infoLabel.textAlignment = .Center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(infoLabel)
        
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .Top, relatedBy: .Equal, toItem: subtitleLabel, attribute: .Bottom, multiplier: 1, constant: 0))*/
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2 - 40)
        var startValue: CGFloat = 0
        var startAngle: CGFloat = 0
        var endValue: CGFloat = 0
        var endAngle: CGFloat = 0
        
        for slice in slices {
            
            startAngle = (startValue * 2 * CGFloat(M_PI)) - CGFloat(M_PI_2)
            endValue = startValue + (slice.value / self.total)
            endAngle = (endValue * 2 * CGFloat(M_PI)) - CGFloat(M_PI_2)
            
            let path = UIBezierPath()
            path.moveToPoint(center)
            path.addArcWithCenter(center, radius: bounds.width / 2 - 50, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            slice.color.setFill()
            path.fill()
            
            // increase start value for next slice
            startValue += slice.value / self.total
        }
        
        // create center donut hole
        let innerPath = UIBezierPath()
        innerPath.moveToPoint(center)
        innerPath.addArcWithCenter(center, radius: bounds.width / 2 - 80, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)
        UIColor.whiteColor().setFill()
        innerPath.fill()
    }
    
}