//
//  ButtonCell.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import UIKit

final class ButtonCell: UITableViewCell {
    var onButtonTap: () -> Void = {}

    @IBOutlet weak var button: UIButton!

    @IBAction func buttonTap(_ sender: Any) {
        onButtonTap()
    }
}
