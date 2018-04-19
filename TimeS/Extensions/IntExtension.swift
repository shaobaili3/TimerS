//
//  IntExtension.swift
//  TimerS
//
//  Created by Shaobai Li on 19/7/17.
//  Copyright © 2017 Shaobai. All rights reserved.
//

import UIKit

extension Int {
    func covertTotalToTimer() -> String {
        var text: String
        let seconds = self % 60
        let minutes = (self / 60) % 60
        let hours = (self / 3600)

        if hours != 0 {
            text = String(hours) + "h"
            if minutes != 0 && seconds != 0 {
                text += "+"
            }
        }
        else if minutes != 0 {
            text = String(minutes) + ":" + String(format: "%.2d", seconds)
        }
        else {
            text = String(seconds) + "s"
        }

        return text
    }

    func convertTotalToSetting() -> String {
        let seconds = self % 60
        let minutes = (self / 60) % 60
        let hours = (self / 3600)
        let text = String(format: "%.2d", hours) + ":" + String(format: "%.2d", minutes) + ":" + String(format: "%.2d", seconds)
        return text
    }
}
