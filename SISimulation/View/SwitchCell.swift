//
//  SwitchCell.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import UIKit

final class SwitchCell: UITableViewCell {

    // MARK: - properties

    var onSwitchChange: (Bool) -> Void = { _ in }

    // MARK: - view properties

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellSwitch: UISwitch!

    // MARK: - actions

    @IBAction func switchSelected(_ sender: UISwitch) {
        onSwitchChange(sender.isOn)
    }
}

