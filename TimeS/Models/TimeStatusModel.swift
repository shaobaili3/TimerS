//
//  TimeStatusModel.swift
//  TimerS
//
//  Created by Shaobai Li on 24/7/17.
//  Copyright © 2017 Shaobai. All rights reserved.
//

import UIKit

final class TimeStatusModel {

    var targetTime: Int {
        get {
            return UserDefaults.standard.integer(forKey: "targetTime")
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "targetTime")
        }
    }

    var startTime: Date {
        get {
            if let time = UserDefaults.standard.object(forKey: "startTime") as? Date {
                return time
            }
            return Date()
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "startTime")
        }
    }

    var stopWatchIsOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "stopWatchIsOn")
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "stopWatchIsOn")
        }
    }

    var totalTime: Double {
        get {
            return UserDefaults.standard.double(forKey: "totalTime")
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "totalTime")
        }
    }

    var timerTag: Int {
        get {
            return UserDefaults.standard.integer(forKey: "timerTag")
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "timerTag")
        }
    }
}
