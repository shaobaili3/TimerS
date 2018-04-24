//
//  AppDelegateExtension.swift
//  Bird
//
//  Created by Bai on 17/7/17.
//  Copyright © 2017 Bai. All rights reserved.
//

import UIKit

extension AppDelegate {
    func configureStyling() {
        styleNavigationBar()
    }

    func styleNavigationBar() {
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    }
}
