//
//  LockTableViewController.swift
//  TimerS
//
//  Created by Shaobai Li on 27/7/17.
//  Copyright © 2017 Shaobai. All rights reserved.
//

import UIKit

class LockTableViewController: UITableViewController {
    var screenLock: ScreenLock? // get this by segue in SettingViewController
    var sectionNum = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(class: SwitchTableViewCell.self)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let lock = screenLock else {
            fatalError("screenLock doesnot not exist, please chcek segue")
        }

        if lock.mainLock {
            return sectionNum
        }

        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let lock = screenLock else {
            fatalError("screenLock doesnot not exist, please chcek segue")
        }

        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SwitchTableViewCell

        if indexPath.section == 0 {
            let textScreenBrightnessLock = NSLocalizedString("Screen Brightness Lock", comment: "")
            cell.configure(labelText: textScreenBrightnessLock, switchStatus: lock.mainLock)
            cell.uiSwitch.addTarget(self, action: #selector(closeLock), for: .valueChanged)
        } else if indexPath.section == 1 {
            let textTimer = NSLocalizedString("Timer", comment: "")
            let textStopwatch = NSLocalizedString("Stopwatch", comment: "")

            switch indexPath.row {
            case 0:
                cell.configure(labelText: textTimer + " 1", switchStatus: lock.timerLocks[0])
            case 1:
                cell.configure(labelText: textTimer + " 2", switchStatus: lock.timerLocks[1])
            case 2:
                cell.configure(labelText: textTimer + " 3", switchStatus: lock.timerLocks[2])
            case 3:
                cell.configure(labelText: textStopwatch, switchStatus: lock.stopwatchLock)
            default:
                break
            }
            cell.uiSwitch.tag = indexPath.row
            cell.uiSwitch.addTarget(self, action: #selector(closeLocks), for: .valueChanged)
        }

        return cell
    }

    @objc func closeLock(sender: AnyObject) {
        screenLock?.mainLock = sender.isOn
        if sender.isOn {
            sectionNum = 2
            let indexSet = IndexSet([1])
            tableView.insertSections(indexSet, with: .fade)
        } else {
            let indexSet = IndexSet([1])
            tableView.deleteSections(indexSet, with: .fade)
        }
    }

    @objc func closeLocks(sender: AnyObject) {
        if sender.tag == 3 {
            screenLock?.stopwatchLock = sender.isOn
        } else {
            screenLock?.timerLocks[sender.tag] = sender.isOn
        }
    }
}
