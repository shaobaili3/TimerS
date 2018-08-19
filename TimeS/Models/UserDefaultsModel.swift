//
//  UserDefaultsModel.swift
//  Bird
//
//  Created by SHAOBAI LI on 30/11/16.
//  Copyright © 2016 Bai. All rights reserved.
//

import UIKit

// MARK: List of Constants
private let TIMERS_NAMES: [String] = ["t1", "t2", "t3"]
private let TIME = "time"
private let ANNOUNCER = "announcer"
private let REMAINING = "remaining"
private let COUNT_DOWN = "countdown"
private let SCREEN_LOCK = "ScreenLock"
private let STOPWATCH_LOCK = "stopwatchLock"
private let DEFAULT_SETTING = "defaultSetting"

final class ScreenLock {
    var mainLock: Bool
    var timerLocks = [Bool]()
    var stopwatchLock: Bool

    init() {
        mainLock = UserDefaults.standard.bool(forKey: SCREEN_LOCK)
        for index in 0...2 {
            timerLocks.append((UserDefaults(suiteName: TIMERS_NAMES[index])?.bool(forKey: SCREEN_LOCK)) ?? true)
        }
        stopwatchLock = UserDefaults.standard.bool(forKey: STOPWATCH_LOCK)
    }

    func saveLocks() {
        UserDefaults.standard.set(mainLock, forKey: SCREEN_LOCK)
        for index in 0...2 {
            UserDefaults(suiteName: TIMERS_NAMES[index])?.set(timerLocks[index], forKey: SCREEN_LOCK)
        }
        UserDefaults.standard.set(stopwatchLock, forKey: STOPWATCH_LOCK)
    }
}

final class Announcer {
    var main = [Bool]()
    var remaining = [[Int]]()
    var countdown = [[Int]]()

    init() {
        var intArray = [Int]()
        for index in 0...2 {
            //load main switchers
            main.append(UserDefaults(suiteName: TIMERS_NAMES[index])?.bool(forKey: ANNOUNCER) ?? true)
            //load remaining
            intArray = UserDefaults(suiteName: TIMERS_NAMES[index])?.array(forKey: REMAINING) as? [Int] ?? [15, 30, 120, 180, 240, 300, 600, 900]
            remaining.append(intArray)
            //load countdown
            intArray = UserDefaults(suiteName: TIMERS_NAMES[index])?.array(forKey: COUNT_DOWN) as? [Int] ?? [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
            countdown.append(intArray)
        }
    }

    func saveAnnouncers() {
        UserDefaults.standard.set(main, forKey: ANNOUNCER)
        for index in 0...2 {
            //save main switchers
            UserDefaults(suiteName: TIMERS_NAMES[index])?.set(main[index], forKey: ANNOUNCER)
            //save remaining
            UserDefaults(suiteName: TIMERS_NAMES[index])?.set(remaining[index], forKey: REMAINING)
            //save countdown
            UserDefaults(suiteName: TIMERS_NAMES[index])?.set(countdown[index], forKey: COUNT_DOWN)
        }
    }
}

final class UserDefaultsModel {
    let t1settings = UserDefaults(suiteName: TIMERS_NAMES[0])
    let t2settings = UserDefaults(suiteName: TIMERS_NAMES[1])
    let t3settings = UserDefaults(suiteName: TIMERS_NAMES[2])

    init() {
        if UserDefaults.standard.bool(forKey: DEFAULT_SETTING) == false {
            UserDefaults.standard.set(true, forKey: DEFAULT_SETTING)
            defaultSetting()
        }
    }

    func defaultSetting() {
        //set tiemrs status to reset
        UserDefaults.standard.set(-1, forKey: "targetTime")

        //Set timers default time
        t1settings?.set(30, forKey: TIME)
        t1settings?.set(true, forKey: SCREEN_LOCK)
        t2settings?.set(45, forKey: TIME)
        t2settings?.set(true, forKey: SCREEN_LOCK)
        t3settings?.set(1800, forKey: TIME)
        t3settings?.set(true, forKey: SCREEN_LOCK)

        //set the screen brightness lock for stopwatch
        UserDefaults.standard.set(true, forKey: STOPWATCH_LOCK)

        //Open the screen brightness lock
        UserDefaults.standard.set(true, forKey: SCREEN_LOCK)
        for index in 0...2 {
            //save main switchers
            UserDefaults(suiteName: TIMERS_NAMES[index])?.set(true, forKey: ANNOUNCER)
        }
    }
}
