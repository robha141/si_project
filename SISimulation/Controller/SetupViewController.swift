//
//  SetupViewController.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import UIKit

private enum SetupViewControllerItems {
    case students
    case panel(value: Bool)
    case simulate
}

final class SetupViewController: UITableViewController {

    // MARK: - properties

    private var items = [
        SetupViewControllerItems.students,
        SetupViewControllerItems.panel(value: false),
        SetupViewControllerItems.simulate
    ]
    private var studentSetup = StudentSetup()
    private let switchCellId = "SwitchCell"
    private let detailCellId = "DetailCell"
    private let buttonCellId = "ButtonCell"

    // MARK: - prepareForSegue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StudentSetup",
            let controller = segue.destination as? SetupStudentsViewController {
            controller.studentSetup = studentSetup
            controller.onSave = { [weak self] in
                self?.studentSetup = $0
            }
        }
    }

    // MARK: - simulate

    private func simulate() {
        // TODO: - init simulation
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch items[indexPath.row] {
        case .students:
            performSegue(
                withIdentifier: "StudentSetup",
                sender: self)
        default:
            break
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case .students:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: detailCellId,
                for: indexPath)
            cell.textLabel?.text = "Student distribution setup"
            return cell
        case let .panel(value: value):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: switchCellId,
                for: indexPath) as! SwitchCell
            cell.cellSwitch.isOn = value
            cell.titleLabel.text = "Panel is on/off"
            cell.onSwitchChange = { [weak self] in
                self?.items[indexPath.row] = SetupViewControllerItems.panel(value: $0)
            }
            return cell
        case .simulate:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: buttonCellId,
                for: indexPath) as! ButtonCell
            cell.button.setTitle("Simulate", for: .normal)
            cell.onButtonTap = { [weak self] in
                self?.simulate()
            }
            return cell
        }
    }
}
