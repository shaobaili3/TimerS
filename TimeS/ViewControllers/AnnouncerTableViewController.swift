//
//  AnnouncerTableViewController.swift
//  TimerS
//
//  Created by Shaobai Li on 1/8/17.
//  Copyright © 2017 Shaobai. All rights reserved.
//

import UIKit

class AnnouncerTableViewController: UITableViewController {

    var announcer: Announcer?
    var selectedTimer: Int?
    var countdown: [String] = ["Overtime", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    var remaining: [Int: String] = [5: "Five seconds remaining", 10: "Ten seonds remaining", 15: "Fifteen sconds remaining", 30: "Thirty sconds remaining", 120: "Two minutes remaining", 180: "Three minutes remaining", 240: "Four minutes remaining", 300: "Five minutes remaining", 600: "Ten minutes remaining", 900: "Fifteen minutes remaining"]
    var remainingTime: [Int] = []
    var numOfSection: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(class: SwitchTableViewCell.self)
        tableView.register(class: AnnouncerTableViewCell.self)
        
        remainingTime = Array(remaining.keys)
        remainingTime.sort { $0 < $1 } // = list.sort(sort: <)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return numOfSection
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        if indexPath.section == 1 {
            if currentCell?.accessoryType == .checkmark {
                currentCell?.accessoryType = .none
                let index = announcer?.countdown[selectedTimer!].index(of: indexPath.row)
                announcer?.countdown[selectedTimer!].remove(at: index!)
            } else {
                currentCell?.accessoryType = .checkmark
                announcer?.countdown[selectedTimer!].append(indexPath.row)
            }
        } else if indexPath.section == 2 {
            if currentCell?.accessoryType == .checkmark {
                currentCell?.accessoryType = .none
                let index = announcer?.remaining[selectedTimer!].index(of: remainingTime[indexPath.row])
                announcer?.remaining[selectedTimer!].remove(at: index!)
            } else {
                currentCell?.accessoryType = .checkmark
                announcer?.remaining[selectedTimer!].append(remainingTime[indexPath.row])
            }
        }
        if (announcer?.remaining[selectedTimer!].isEmpty)! && (announcer?.countdown[selectedTimer!].isEmpty)! {
            announcer?.main[selectedTimer!] = false
            self.tableView.reloadData()
        } else {
            announcer?.main[selectedTimer!] = true
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SwitchTableViewCell
            cell.uiSwitch.addTarget(self, action: #selector(AnnouncerTableViewController.closeAnnouncer), for: .valueChanged)
            let textAnnouncer = NSLocalizedString("Announcer", comment: "")
            cell.configure(labelText: textAnnouncer, switchStatus: (announcer?.main[selectedTimer!])!)
            return cell
        } else if indexPath.section == 3 {
                let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as AnnouncerTableViewCell
                cell.textLabel?.text = "Reset to Default"
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.4579983354, blue: 0, alpha: 1)
                cell.accessoryType = .none
                return cell
        }
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as AnnouncerTableViewCell
        
        if indexPath.section == 2 {
            let currentRemaining = remainingTime[indexPath.row]
            cell.textLabel?.text = remaining[currentRemaining]
            if (announcer?.remaining[selectedTimer!].contains(currentRemaining))! {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else if indexPath.section == 1 {
            cell.textLabel?.text = countdown[indexPath.row]
            if (announcer?.countdown[selectedTimer!].contains(indexPath.row))! {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.textColor = .white
        return cell
    }


    @objc func closeAnnouncer(sender: AnyObject) {
        if sender.isOn {
            announcer?.main[selectedTimer!] = true
            announcer?.countdown[selectedTimer!] = [0,1,2,3,4,5,6,7,8,9,10]
            announcer?.remaining[selectedTimer!] = remainingTime
        } else {
            announcer?.main[selectedTimer!] = false
            announcer?.countdown[selectedTimer!] = []
            announcer?.remaining[selectedTimer!] = []
        }
        self.tableView.reloadData()
    }

}
