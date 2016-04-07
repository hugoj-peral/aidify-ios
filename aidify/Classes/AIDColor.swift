//
//  AIDColor.swift
//  aidify
//
//  Created by Hugo Peral on 20/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

enum AIDColor {
    case Black
    case Green
    case Orange
    case Pink
    case Blue
    case Yellow
    case Purple
    case DarkGreen
    case DarkOrange
    case DarkPink
    case DarkBlue
    case DarkYellow
    case DarkPurple
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
        case .DarkGreen: return UIColor(red: 73.0/255.0, green: 144.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        case .DarkOrange: return UIColor(red: 232.0/255.0, green: 134.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        case .DarkPink: return UIColor(red: 204.0/255.0, green: 86.0/255.0, blue: 121.0/255.0, alpha: 1.0)
        case .DarkBlue: return UIColor(red: 56.0/255.0, green: 145.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        case .DarkYellow: return UIColor(red: 240.0/255.0, green: 193.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        case .DarkPurple: return UIColor(red: 143.0/255.0, green: 99.0/255.0, blue: 179.0/255.0, alpha: 1.0)
        }
    }
}