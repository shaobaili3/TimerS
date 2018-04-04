//
//  TimeViewController.swift
//  Bird
//
//  Created by Bai on 13/11/16.
//  Copyright © 2016 Bai. All rights reserved.
//

import UIKit
import AVFoundation

class TimeViewController: UIViewController {

    var sound = AnnounceModel()
    let userDefault = UserDefaultsModel()
    let status = TimeStatusModel()

    var btimer: Timer?
    var selectedButton: UIButton?
    var screenLock = ScreenLock()
    var screenLockisOn: Bool = true {
        didSet {
            UIApplication.shared.isIdleTimerDisabled = screenLockisOn
        }
    }

    var t1settings = UserDefaults(suiteName: "t1")
    var t2settings = UserDefaults(suiteName: "t2")
    var t3settings = UserDefaults(suiteName: "t3")

    @IBOutlet var timeBackground: UIView!
    @IBOutlet weak var StopWatchButton: UIButton!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet var resetLabel: UILabel!

    @IBOutlet weak var t1Button: UIButton!
    @IBOutlet weak var t2Button: UIButton!
    @IBOutlet weak var t3Button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonLabels()

        self.navigationController?.navigationBar.isTranslucent = true

        //Remove line between Navigationbar and View
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        //Add gesture to MainLabel
        let tapLabel: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetTime))
        tapLabel.delegate = self
        mainLabel.isUserInteractionEnabled = true
        mainLabel.addGestureRecognizer(tapLabel)

        //Add gesture to UINavigationBar title
        let tapTitle: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetTime))
        tapTitle.delegate = self
        self.navigationItem.titleView = resetLabel
        self.navigationItem.titleView?.isUserInteractionEnabled = true
        self.navigationItem.titleView?.addGestureRecognizer(tapTitle)

        //Default MainLabel
        display.font = display.font.withSize(200)
        display.text = "--"

        //Update display when defaults change
        NotificationCenter.default.addObserver(self, selector: #selector(TimeViewController.setButtonLabels), name: UserDefaults.didChangeNotification, object: nil)

        restoreStatus()
    }

    func restoreStatus() {
        let textStop = NSLocalizedString("Stop", comment: "")
        if status.targetTime != -1 {
            switch status.timerTag {
            case 1:
                selectedButton = t1Button
            case 2:
                selectedButton = t2Button
            case 3:
                selectedButton = t3Button
            default:
                print("timer buttons tag invalid ")
                break
            }
            selectedButton?.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            btimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(TimeViewController.change), userInfo: nil, repeats: true)
        } else if status.totalTime != 0 {
            if status.stopWatchIsOn {
                StopWatchButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                btimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TimeViewController.change), userInfo: nil, repeats: true)
                timeBackground.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                StopWatchButton.setTitle(textStop, for: UIControlState.normal)
            }
            else {
                timeBackground.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                let displayTime = status.totalTime
                covertTimeInterval(interval: TimeInterval(displayTime))
            }
        }
        else if status.stopWatchIsOn {
            StopWatchButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            btimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TimeViewController.change), userInfo: nil, repeats: true)
            timeBackground.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            StopWatchButton.setTitle(textStop, for: UIControlState.normal)
        }
        //reset mode
        return
    }

    @IBAction func pressTimersButoon(_ sender: UIButton) {
        reset()
        resetSelectedButtonBackground()
        selectedButton = sender
        btimer?.invalidate()
        btimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(TimeViewController.change), userInfo: nil, repeats: true)

        timeBackground.backgroundColor = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1)

        status.timerTag = sender.tag
        switch sender.tag {
        case 1:
            status.targetTime = (t1settings?.integer(forKey: "time"))!
        case 2:
            status.targetTime = (t2settings?.integer(forKey: "time"))!
        case 3:
            status.targetTime = (t3settings?.integer(forKey: "time"))!
        default:
            print("timer buttons tag invalid ")
            break
        }

        //display.font = display.font.withSize(200)
        sender.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        status.startTime = Date()
        covertTimeInterval(interval: Double(status.targetTime))
    }

    @IBAction func pressStopWatchButton(_ sender: UIButton) {
        if status.targetTime != -1 {
            //reset timer when user press this button when timer is running
            reset()
        }
        status.targetTime = -1
        btimer?.invalidate()
        resetSelectedButtonBackground()
        if status.stopWatchIsOn == false {
            sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            status.stopWatchIsOn = true
            status.startTime = Date()
            btimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TimeViewController.change), userInfo: nil, repeats: true)
            timeBackground.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            let textStop = NSLocalizedString("Stop", comment: "")
            sender.setTitle(textStop, for: UIControlState.normal)
        }
        else {
            status.stopWatchIsOn = false
            let textStart = NSLocalizedString("Start", comment: "")
            sender.setTitle(textStart, for: UIControlState.normal)
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            status.totalTime += Date().timeIntervalSince(status.startTime)
        }
    }

    @objc func setButtonLabels () {
        //refresh locks from userDefault
        screenLock = ScreenLock()

        //refresh annoucners from userDefault
        sound = AnnounceModel()

        t1Button.setTitle(t1settings?.integer(forKey: "time").covertTotalToTimer(), for: .normal)
        t2Button.setTitle(t2settings?.integer(forKey: "time").covertTotalToTimer(), for: .normal)
        t3Button.setTitle(t3settings?.integer(forKey: "time").covertTotalToTimer(), for: .normal)
    }

    func covertTimeInterval(interval: TimeInterval) {
        let ti = abs(Int(interval))
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)

        if status.targetTime == -1 { //format mainLabel for Stopwatch mode

            if screenLock.mainLock {
                screenLockisOn = screenLock.stopwatchLock
            } else {
                screenLockisOn = false
            }

            let msec = interval.truncatingRemainder(dividingBy: 1)
            if hours != 0 {
                display.font = display.font.withSize(60)
                display.text = String(hours) + ":" + String(format: "%.2d", minutes) + ":" + String(format: "%.2d", seconds) + "." + String(format: "%.2d", Int(msec * 100))
            }
            else {
                display.font = display.font.withSize(80)
                display.text = String(format: "%.2d", minutes) + ":" + String(format: "%.2d", seconds) + "." + String(format: "%.2d", Int(msec * 100))
            }
            return
        }

        //fomat mainLabel for timer mode

        if screenLock.mainLock {
            screenLockisOn = screenLock.timerLocks[status.timerTag - 1]
        } else {
            screenLockisOn = false
        }

        if hours != 0 {
            display.font = display.font.withSize(81)
            display.text = String(hours) + ":" + String(format: "%.2d", minutes) + ":" + String(format: "%.2d", seconds)
        }
        else if minutes != 0 {
            if minutes < 10 {
                display.font = display.font.withSize(160)
            }
            else {
                display.font = display.font.withSize(125)
            }
            display.text = String(minutes) + ":" + String(format: "%.2d", seconds)
        }
        else {
            display.font = display.font.withSize(200)
            display.text = String(seconds)
        }

        if status.stopWatchIsOn == false && status.totalTime == 0 {
            sound.playSound(displayTime: Int(interval))
        }
    }

    @objc func change() {

        if status.targetTime == -1 {
            let displayTime = Date().timeIntervalSince(status.startTime) + status.totalTime
            //display.text = String(format: "%.2f", displayTime)
            covertTimeInterval(interval: TimeInterval(displayTime))
        }
        else {
            display.textColor = UIColor.white
            let intervalTime = status.startTime.timeIntervalSinceNow
            let displayTime = Int(intervalTime) + status.targetTime
            covertTimeInterval(interval: TimeInterval(displayTime))

            if displayTime < 1 {
                timeBackground.backgroundColor = UIColor(red: 39 / 255, green: 174 / 255, blue: 96 / 255, alpha: 1)
                selectedButton?.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                selectedButton?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControlState.normal)
            }
        }
    }

    //return selected button background to default
    func resetSelectedButtonBackground() {
        selectedButton?.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        //selectedButton?.layer.borderWidth = 0.0
        let textStart = NSLocalizedString("Start", comment: "")
        StopWatchButton.setTitle(textStart, for: UIControlState.normal)
        StopWatchButton.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        selectedButton?.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControlState.normal)
    }

    @IBAction func lockBarButton(_ sender: UIBarButtonItem) {
//        let lockButton = UIButton()
//        lockButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        lockButton.addTarget(self, action: #selector(TimeViewController.lockBarButton(_:)), for: .touchUpInside)
//
//        if screenLockisOn {
//            screenLockisOn = false
//            lockButton.setImage(#imageLiteral(resourceName: "lock"), for: .normal)
//            let br = UIBarButtonItem(customView: lockButton)
//            self.navigationItem.setRightBarButton(br, animated: true)
//        }
//            else {
//                screenLockisOn = true
//                lockButton.setImage(#imageLiteral(resourceName: "unlock"), for: .normal)
//                let br = UIBarButtonItem(customView: lockButton)
//                self.navigationItem.setRightBarButton(br, animated: true)
//        }
    }

    @IBAction func ButtonsTouchDown(_ sender: UIButton) {
        //        if selectedButton != sender {
        //            sender.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        //        }
        //        else{
        //            sender.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        //        }
    }

    @IBAction func ButtonsTouchUpOutside(_ sender: UIButton) {
        //        if selectedButton != sender {
        //            sender.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        //        }
        //        else{
        //            sender.backgroundColor = UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1)
        //        }
    }
}

extension TimeViewController: UIGestureRecognizerDelegate {
    @objc func resetTime(sender: UITapGestureRecognizer) {
        reset()
        display.font = display.font.withSize(200)
        display.text = "--"
        timeBackground.backgroundColor = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1)
        resetSelectedButtonBackground()

        screenLockisOn = false
    }

    func reset() {
        status.stopWatchIsOn = false
        status.totalTime = 0
        status.targetTime = -1
        btimer?.invalidate()

        sound = AnnounceModel()
    }
}

