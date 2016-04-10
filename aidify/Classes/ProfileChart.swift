//
//  ProfileChart.swift
//  aidify
//
//  Created by salazar on 6/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

class Piechart: UIView {
    
    var slices: [UserStatItem] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    private func calculatePunctuation(total: Int) -> String {
        
        var result: String = ""
        let userClassRaw:Int = total / 500
        let lowerUserClass = "abcdefghijklmnopqrstuvwxyz"
        let userClassList = Array(lowerUserClass.characters)
        let base = userClassList.count
        
        var quotient = userClassRaw / base
        var remainder = userClassRaw %  base
        
        repeat {
            result = String(userClassList[remainder]) + result
            quotient = quotient / base
            remainder = quotient %  base
        } while quotient != 0
        
        return result
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        var startValue: CGFloat = 0
        var startAngle: CGFloat = 0
        var endValue: CGFloat = 0
        var endAngle: CGFloat = 0
        slices.sortInPlace { abs($0.value) > abs($1.value) }
        var total = CGFloat(slices.reduce(0) { $0 + abs($1.value) })
        var displayPercentages = true
        
        if slices.count > 0 && total == 0 {
            let newValue = 100/slices.count
            slices = slices.map({UserStatItem(type: $0.type, value:newValue, expanded: $0.expanded)})
            total = CGFloat(slices.reduce(0) { $0 + abs($1.value) })
            displayPercentages = false
        }
        
        let angle0: CGFloat = (slices.first != nil) ? CGFloat(M_PI_2) - (CGFloat(abs(slices.first!.value)) * CGFloat(M_PI) / total) : 0
        
        let radius = bounds.width / 2 - 70
        let strokeWidth = 25.0
        let radiusWithStroke = radius + CGFloat(strokeWidth)
        let center = CGPoint(x: bounds.width / 2, y: radiusWithStroke + 40)
        
        let circleSize = CGFloat(40.0)
        
        let textFont = UIFont(name: "Raleway", size: 20)
        let textColor = UIColor.whiteColor()
        let textDrawingContext = NSStringDrawingContext()
        textDrawingContext.minimumScaleFactor = 0.2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        paragraphStyle.lineBreakMode = .ByClipping
        var textAttributes = [ NSForegroundColorAttributeName: textColor, NSFontAttributeName: textFont!, NSParagraphStyleAttributeName: paragraphStyle]
        
        for slice in slices {
            
            startAngle = (startValue * 2 * CGFloat(M_PI)) + angle0
            endValue = startValue + (CGFloat(abs(slice.value)) / total)
            endAngle = (endValue * 2 * CGFloat(M_PI)) + angle0
            
            let colorWithAlpha = slice.type.color.colorWithAlphaComponent(0.85)
            
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.lineWidth = CGFloat(strokeWidth)
            colorWithAlpha.setStroke()
            path.stroke()
            
            if displayPercentages {
                let sliceCircleSize = circleSize * (CGFloat(abs(slice.value))/total + 1)
                
                let halfAngle = (startAngle + endAngle) / 2.0
                let circleRect = CGRect(x: center.x + radiusWithStroke * cos(halfAngle) - circleSize / 2.0, y: center.y + radiusWithStroke * sin(halfAngle) - sliceCircleSize / 2.0, width: sliceCircleSize, height: sliceCircleSize)
                let circle = UIBezierPath(ovalInRect: circleRect)
                colorWithAlpha.setFill()
                circle.fill()
                
                let text: NSString = "\(Int((Double(abs(slice.value))/Double(total))*100.0))%"
                let labelSize = text.sizeWithAttributes(textAttributes)
                text.drawInRect(CGRect(origin: CGPoint(x: circleRect.origin.x, y: circleRect.origin.y + (circleRect.size.height - labelSize.height) / 2), size: circleRect.size), withAttributes: textAttributes)
            }
            
            // increase start value for next slice
            startValue += CGFloat(abs(slice.value)) / total
        }
        
        let innerRadius = radius - CGFloat(strokeWidth) - 5
        if let firstSlice = slices.first {
            let mainCircleRect = CGRect(x: center.x - innerRadius, y: center.y - innerRadius, width: innerRadius * 2, height: innerRadius * 2)
            let mainCircle = UIBezierPath(ovalInRect: mainCircleRect)
            firstSlice.type.color.setFill()
            mainCircle.lineWidth = CGFloat(strokeWidth - 5)
            AIDColor.Gray.color().setStroke()
            mainCircle.fill()
            mainCircle.stroke()
            
            let mainTextFont = UIFont(name: "Raleway-Bold", size: 120)
            textAttributes[NSFontAttributeName] = mainTextFont
            let text: NSString = calculatePunctuation(Int(total))
            let labelSize = text.sizeWithAttributes(textAttributes)
            text.drawWithRect(CGRect(origin: CGPoint(x: mainCircleRect.origin.x, y: mainCircleRect.origin.y + (mainCircleRect.size.height - labelSize.height) / 2), size: mainCircleRect.size), options:.UsesLineFragmentOrigin, attributes: textAttributes, context: textDrawingContext)
            
            
            textAttributes[NSForegroundColorAttributeName] = firstSlice.type.color
            
            let arcImage = UIImage(named: "totalPoints")!.imageWithColor(firstSlice.type.color)
            let arcImagePoint = CGPoint(x: Double(center.x) - Double(radius) - strokeWidth + 10, y: Double(center.y) + Double(radius) + strokeWidth - 10)
            arcImage.drawAtPoint(arcImagePoint)
            
            let pointsTitleFont = UIFont(name: "Raleway-Bold", size: 36)
            textAttributes[NSFontAttributeName] = pointsTitleFont
            let pointsTitle:NSString = "\(displayPercentages ? Int(total) : 0)"
            let pointsTitleSize = pointsTitle.sizeWithAttributes(textAttributes)
            let pointsTitlePoint = CGPoint(x: arcImagePoint.x + arcImage.size.width - 20, y: arcImagePoint.y + arcImage.size.height - pointsTitleSize.height)
            pointsTitle.drawAtPoint(pointsTitlePoint, withAttributes: textAttributes)
            
            let pointsSubtitleFont = UIFont(name: "Raleway-Bold", size: 18)
            textAttributes[NSFontAttributeName] = pointsSubtitleFont
            let pointsSubtitle:NSString = "total points"
            pointsSubtitle.drawAtPoint(CGPoint(x: pointsTitlePoint.x, y: pointsTitlePoint.y + pointsTitleSize.height - 4), withAttributes: textAttributes)
        }
    }
    
}