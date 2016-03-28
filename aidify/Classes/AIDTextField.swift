//
//  AIDTextField.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

class AIDTextField: UITextField {
    
    @IBInspectable var underlineWidth: CGFloat = 2.0
    @IBInspectable var underlineColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    @IBInspectable var placeholderColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
    
    var placeholderFont: UIFont = UIFont(name: "Raleway-Bold", size:24)!
    var placeholderAlignment: NSTextAlignment = .Center
    
    lazy var underline : CALayer = {
        let border = CALayer()
        border.borderColor = self.underlineColor.CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - self.underlineWidth, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = self.underlineWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        return border
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        underline.frame = CGRect(x: 0, y: self.frame.size.height - self.underlineWidth, width:  self.frame.size.width, height: self.frame.size.height)
    }
    
    // placeholder position
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 0, self.underlineWidth);
    }
    
    // text position
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 0, self.underlineWidth);
    }
    
    override func drawPlaceholderInRect(rect: CGRect) {
        guard let text = self.placeholder else {return}
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.placeholderAlignment
        
        let attributes = [NSForegroundColorAttributeName: self.placeholderColor, NSFontAttributeName: self.placeholderFont, NSParagraphStyleAttributeName: paragraphStyle]
        
        let placeholder = NSAttributedString(string: text, attributes: attributes)
        
        self.attributedPlaceholder = placeholder
        self.attributedPlaceholder?.drawInRect(rect)
    }
}
