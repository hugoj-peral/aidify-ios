//
//  UITableViewCell+Initialization.swift
//  aidify
//
//  Created by salazar on 2/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static func relatedNib() -> UINib? {
        return UINib(nibName: String(self), bundle: nil)
    }
    
    static func reuseIdentifier() -> String {
        return String(self)
    }
    
}

extension UITableView {
    
    func registerCell<T where T:UITableViewCell>(classCell: T.Type) {
        self.registerNib(T.relatedNib(), forCellReuseIdentifier: T.reuseIdentifier())
    }
}

extension UIViewController {
    static func create() -> Self {
        return self.init(nibName: String(self), bundle:nil)
    }
}