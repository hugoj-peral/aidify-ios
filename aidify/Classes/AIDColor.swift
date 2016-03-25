//
//  AIDColor.swift
//  aidify
//
//  Created by Hugo Peral on 20/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

enum AIDColor: String {
    case Black
    case Green
    case Orange
    case Pink
    case Blue
    case Yellow
    case Purple
}

protocol AIDColorRepresentation {
    func color() -> UIColor
}

extension AIDColor : AIDColorRepresentation {
    func color() -> UIColor {
        switch self {
        case .Black: return UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        case .Green: return UIColor(red: 107.0/255.0, green: 173.0/255.0, blue: 107.0/255.0, alpha: 1.0)
        case .Orange: return UIColor(red: 255.0/255.0, green: 167.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        case .Pink: return UIColor(red: 215.0/255.0, green: 119.0/255.0, blue: 147.0/255.0, alpha: 1.0)
        case .Blue: return UIColor(red: 82.0/255.0, green: 168.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        case .Yellow: return UIColor(red: 255.0/255.0, green: 214.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        case .Purple: return UIColor(red: 165.0/255.0, green: 134.0/255.0, blue: 190.0/255.0, alpha: 1.0)
        }
    }
}