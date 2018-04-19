//
//  SettingNavigationController.swift
//  TimerS
//
//  Created by Shaobai Li on 22/8/17.
//  Copyright © 2017 Shaobai. All rights reserved.
//

import UIKit

class SettingNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            return super.supportedInterfaceOrientations
        }
        return.portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            return super.preferredInterfaceOrientationForPresentation
        }
        return.portrait
    }

}
