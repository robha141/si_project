//
//  SetupStudentsViewController.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import UIKit

enum SetupStudentsViewControllerSections: Int, CaseIterable {
    case numberOfStudents
    case fieldsDistribution
    case categoriesDistribution
}

final class SetupStudentsViewController: UITableViewController {

    // MARK: - properties

    var studentSetup: StudentSetup?
    var onSave: (StudentSetup) -> Void = { _ in }
    private let distributionCellId = "DistributionCell"

    // MARK: - view properties

    @IBOutlet weak var numberOfStudentsTextField: UITextField!

    // MARK: - lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        guard let numberOfStudents = studentSetup?.numberOfStudents else { return }
        numberOfStudentsTextField.text = "\(numberOfStudents)"
    }

    // MARK: - actions

    @IBAction func saveDistribution(_ sender: UIBarButtonItem) {
        guard let setup = studentSetup else { return }
        do {
            try setup.evaluateValues()
            onSave(setup)
            navigationController?.popViewController(animated: true)
        } catch let error as StudentSetupError {
            makeAlert(
                title: "Items are not distributed properly",
                message: error.localizedDescription)
        } catch {
            makeAlert(
                title: "Items are not distributed properly",
                message: error.localizedDescription)
        }
    }
    
    @IBAction func newNumberOfStudents(_ sender: UITextField) {
        studentSetup?.numberOfStudents = Int(sender.text ?? "0") ?? 0
    }


    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return studentSetup?.distributions.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (studentSetup?.distributions[section].categoriesDistribution.count ?? 0) + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let setup = studentSetup else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(
            withIdentifier: distributionCellId,
            for: indexPath) as! DistributionSetupCell
        switch indexPath.row {
        case 0:
            let item = setup.distributions[indexPath.section]
            cell.leadingOffset.constant = 16
            cell.titleLabel.text = item.field.title
            cell.distribution = item.distribution
            cell.onDistributionChange = { [weak self] in
                self?.studentSetup?.distributions[indexPath.section].distribution = $0
            }
        default:
            let item = setup
                .distributions[indexPath.section]
                .categoriesDistribution[indexPath.row - 1]
            cell.leadingOffset.constant = 24
            cell.titleLabel.text = item.category.title
            cell.distribution = item.distribution
            cell.onDistributionChange = { [weak self] in
                self?.studentSetup?
                    .distributions[indexPath.section]
                    .categoriesDistribution[indexPath.row - 1].distribution = $0
            }
        }
        return cell
    }
}
