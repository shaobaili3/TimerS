//
//  SwitchTableViewCell.swift
//  TimerS
//
//  Created by Shaobai Li on 26/7/17.
//  Copyright © 2017 Shaobai. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var uiSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(labelText: String, switchStatus: Bool) {
        label.text = labelText
        uiSwitch.isOn = switchStatus
    }
}
