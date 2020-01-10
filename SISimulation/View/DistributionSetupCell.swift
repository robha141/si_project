//
//  DistributionSetupCell.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import UIKit

final class DistributionSetupCell: UITableViewCell {

    // MARK: - properties

    var onDistributionChange: (Int) -> Void = { _ in }
    private let picker = UIPickerView()
    var distribution: Int = 1 {
        didSet {
            picker.selectRow(distribution - 1, inComponent: 0, animated: false)
            distributionField.text = "\(distribution) %"
        }
    }

    // MARK: - view properties

    @IBOutlet weak var leadingOffset: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distributionField: UITextField!

    // MARK: - nib

    override func awakeFromNib() {
        super.awakeFromNib()

        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneTap))
        toolbar.setItems([spaceButton, doneButton], animated: false)

        distributionField.inputAccessoryView = toolbar
        distributionField.inputView = picker

        picker.delegate = self
        picker.dataSource = self
    }

    // MARK: - toolbar action

    @objc private func doneTap() {
        endEditing(true)
    }
}

extension DistributionSetupCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
}

extension DistributionSetupCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        distribution = row + 1
        onDistributionChange(distribution)
    }
}
