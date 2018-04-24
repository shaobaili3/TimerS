//
//  ReusableView.swift
//  chatApp
//
//  Created by Shaobai Li on 1/8/17.
//  Copyright © 2017 Shaobai. All rights reserved.
//

import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
