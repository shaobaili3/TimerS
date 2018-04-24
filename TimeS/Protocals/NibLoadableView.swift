//
//  NibLoadableView.swift
//  chatApp
//
//  Created by Shaobai Li on 1/8/17.
//  Copyright © 2017 Shaobai. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }
}
