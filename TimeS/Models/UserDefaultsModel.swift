//
//  UserDefaultsModel.swift
//  Bird
//
//  Created by SHAOBAI LI on 30/11/16.
//  Copyright © 2016 Bai. All rights reserved.
//

import UIKit
let timersName: [String] = ["t1", "t2", "t3"]
let timeKey = "time"
let announceKey = "announcer"
let remainingKey = "remainingKey"
let countdownKey = "countdown"
let lock = "ScreenLock"
let slock = "stopwatchLock"
let def = "defaultSetting"


class ScreenLock {
    var mainLock: Bool
    var timerLocks = [Bool]()
    var stopwatchLock: Bool

    init() {
        mainLock = UserDefaults.standard.bool(forKey: lock)
        for index in 0...2 {
            timerLocks.append((UserDefaults(suiteName: timersName[index])?.bool(forKey: lock)) ?? true)
        }

        stopwatchLock = UserDefaults.standard.bool(forKey: slock)
    }

    func saveLocks() {
        UserDefaults.standard.set(mainLock, forKey: lock)
        for index in 0...2 {
            UserDefaults(suiteName: timersName[index])?.set(timerLocks[index], forKey: lock)
        }
        UserDefaults.standard.set(stopwatchLock, forKey: slock)
    }
}

class Announcer {
    var main: [Bool] = []
    var remaining: [Array<Int>] = []
    var countdown: [Array<Int>] = []

    init() {
        var intArray: [Int] = []
        for index in 0...2 {
            //load main switchers
            main.append(UserDefaults(suiteName: timersName[index])?.bool(forKey: announceKey) ?? true)
            
            //load remaining
            intArray = UserDefaults(suiteName: timersName[index])?.array(forKey: remainingKey) as? [Int] ?? [15, 30, 120, 180, 240, 300, 600, 900]
            remaining.append(intArray)
            
            //load countdown
            intArray = UserDefaults(suiteName: timersName[index])?.array(forKey: countdownKey) as? [Int] ?? [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
            countdown.append(intArray)
        }
    }

    func saveAnnouncers() {
        UserDefaults.standard.set(main, forKey: announceKey)
        for index in 0...2 {
            //save main switchers
            UserDefaults(suiteName: timersName[index])?.set(main[index], forKey: announceKey)
            
            //save remaining
            UserDefaults(suiteName: timersName[index])?.set(remaining[index], forKey: remainingKey)
            
            //save countdown
            UserDefaults(suiteName: timersName[index])?.set(countdown[index], forKey: countdownKey)
        }
    }
}

class UserDefaultsModel {
    let t1settings = UserDefaults(suiteName: timersName[0])
    let t2settings = UserDefaults(suiteName: timersName[1])
    let t3settings = UserDefaults(suiteName: timersName[2])

    init() {
        if UserDefaults.standard.bool(forKey: def) == false {
            UserDefaults.standard.set(true, forKey: def)
            defaultSetting()
        }
    }

    func defaultSetting() {
        //set tiemrs status to reset
        UserDefaults.standard.set(-1, forKey: "targetTime")

        //Set timers default time
        t1settings?.set(30, forKey: timeKey)
        t1settings?.set(true, forKey: lock)
        t2settings?.set(45, forKey: timeKey)
        t2settings?.set(true, forKey: lock)
        t3settings?.set(1800, forKey: timeKey)
        t3settings?.set(true, forKey: lock)

        //set the screen brightness lock for stopwatch
        UserDefaults.standard.set(true, forKey: slock)

        //Open the screen brightness lock
        UserDefaults.standard.set(true, forKey: lock)
        
        for index in 0...2 {
            //save main switchers
            UserDefaults(suiteName: timersName[index])?.set(true, forKey: announceKey)
        }
    }
}
