//
//  AIDFont.swift
//  aidify
//
//  Created by Hugo Peral on 20/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

enum AIDFont: String {
    case Header
    case Title
    case Subtitle
}

protocol AIDFontRepresentation {
    func font() -> UIFont
}

extension AIDFont : AIDFontRepresentation {
    func font() -> UIFont {
        switch self {
        case .Header: return UIFont(name: "AllerDisplay", size: 24)!
        case .Title: return UIFont(name: "Raleway-Medium", size:32)!
        case .Subtitle: return UIFont(name: "Raleway-Light", size:18)!
        }
    }
}
