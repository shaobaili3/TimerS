//
//  SettingViewController.swift
//  Bird
//
//  Created by SHAOBAI LI on 24/11/16.
//  Copyright © 2016 Bai. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    struct Timer {
        var name: String
        var time: Int = 0
        var vibrate: Bool?
        var sound: String?
        var announce: [String] = []
        var setting: UserDefaults
    }
    
    var screenLock = ScreenLock()
    var announcer = Announcer()
    
    @IBOutlet weak var t1Button: UIButton!
    @IBOutlet weak var t2Button: UIButton!
    @IBOutlet weak var t3Button: UIButton!
    
    @IBOutlet weak var SoundSettingTable: UITableView!
    @IBOutlet weak var timePickView: TimePickerView!
    
    let t1settings = UserDefaults(suiteName: "t1")
    let t2settings = UserDefaults(suiteName: "t2")
    let t3settings = UserDefaults(suiteName: "t3")
    var t1Time: Int = 0
    var t2Time: Int = 0
    var t3Time: Int = 0
    var selectedTimerButton: UIButton!
    var timerKeys: [String] = ["t1", "t2", "t3"]
    var timers: [Timer] = []
    var selectedTimer: Int = 0
    var selectedButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromDefaults()
        t1Time = (t1settings?.integer(forKey: "time"))!
        t2Time = (t2settings?.integer(forKey: "time"))!
        t3Time = (t3settings?.integer(forKey: "time"))!
        SoundSettingTable.separatorColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        timePickView.delegate = self
        setPickerValue(timerNum: 0)
        selectedButton = t1Button
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //refresh lock and announcer table
        SoundSettingTable.reloadData()
        
        //Change timePickerView seperator lines to white
        if timePickView.subviews.count >= 5 {
            timePickView.subviews[5].backgroundColor = UIColor.white
            timePickView.subviews[4].backgroundColor = UIColor.white
        } else {
            return
        }
    }
    
    @IBAction func timerButtonsTouchUpInside(_ sender: UIButton) {
        selectedButton?.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        selectedButton?.isUserInteractionEnabled = true
        selectedTimerButton = sender
        let timerNum: Int = sender.tag - 1
        setPickerValue(timerNum: timerNum)
        selectedButton = sender
        selectedTimer = timerNum
        sender.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        sender.isUserInteractionEnabled = false
        //TODO: When selected change button text to white
        sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .highlighted)
        SoundSettingTable.reloadData()
    }
    
    @IBAction func leftUIBarAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rightUIBarAction(_ sender: UIBarButtonItem) {
        for timer in timers {
            print("seting time")
            print(timer.time)
            let setting = timer.setting
            setting.set(timer.time, forKey: "time")
            setting.set(timer.vibrate, forKey: "vibrate")
            setting.set(timer.sound, forKey: "sound")
            setting.set(timer.announce, forKey: "announce")
        }
        screenLock.saveLocks()
        announcer.saveAnnouncers()
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadFromDefaults() {
        for timerKey in timerKeys {
            print(timerKey)
            let setting = UserDefaults(suiteName: timerKey)
            let time = setting?.integer(forKey: "time")
            let vibrate = setting?.bool(forKey: "vibrate")
            let sound = setting?.string(forKey: "sound")
            let announce: [String] = []
            let oneTimer: Timer = Timer(name: timerKey, time: time!, vibrate: vibrate, sound: sound, announce: announce, setting: setting!)
            timers.append(oneTimer)
        }
        
        let textTimer = NSLocalizedString("Timer", comment: "")
        t1Button.setTitle(" " + textTimer + " " + "1" + ":  " + timers[0].time.convertTotalToSetting(), for: .normal)
        t2Button.setTitle(" " + textTimer + " " + "2" + ":  " + timers[1].time.convertTotalToSetting(), for: .normal)
        t3Button.setTitle(" " + textTimer + " " + "3" + ":  " + timers[2].time.convertTotalToSetting(), for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "screenLock" {
            if let viewController = segue.destination as? LockTableViewController {
                viewController.screenLock = self.screenLock
            }
        }
        else if segue.identifier == "announcer" {
            if let viewController = segue.destination as? AnnouncerTableViewController {
                viewController.announcer = announcer
                viewController.selectedTimer = selectedTimer
            }
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if timePickView.subviews.count >= 5 {
            timePickView.subviews[5].backgroundColor = UIColor.white
            timePickView.subviews[4].backgroundColor = UIColor.white
        } else {
            return
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textOn = NSLocalizedString("On", comment: "")
        let textOff = NSLocalizedString("Off", comment: "")
        let cell: UITableViewCell
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "sound")!
            cell.detailTextLabel?.text = textOff
            if screenLock.mainLock {
                if screenLock.timerLocks[selectedTimer] {
                    cell.detailTextLabel?.text = textOn
                }
            }
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "announcer")!
            cell.detailTextLabel?.text = announcer.main[selectedTimer] ? textOn : textOff
        default:
            fatalError("Table cell is out of index")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cancel highlight after selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = "\(row)"
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font: UIFont(name: "Georgia", size: 15.0)!, NSAttributedStringKey.foregroundColor: UIColor.white])
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let textTimer = NSLocalizedString("Timer", comment: "")
        timePickView.timeChanged(row: row, component: component)
        
        //if time equals 0s, return to 1s
        if timePickView.totalTimeInSeconds == 0 {
            timePickView.selectRow(1, inComponent: 2, animated: true)
            timePickView.timeChanged(row: 1, component: 2)
        }
        
        selectedButton?.setTitle(" " + textTimer + " " + String(selectedTimer + 1) + ":  " + timePickView.totalTimeInSeconds.convertTotalToSetting(), for: .normal)
        timers[selectedTimer].time = timePickView.totalTimeInSeconds
    }
    
    func setPickerValue(timerNum: Int) {
        let time: Int = timers[timerNum].time
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        timePickView.seconds = seconds
        timePickView.minutes = minutes
        timePickView.hours = hours
        timePickView.selectRow(hours, inComponent: 0, animated: true)
        timePickView.selectRow(minutes, inComponent: 1, animated: true)
        timePickView.selectRow(seconds, inComponent: 2, animated: true)
    }
}
