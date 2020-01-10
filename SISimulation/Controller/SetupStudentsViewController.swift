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

    var studentSetup: StudentSetup? {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SetupStudentsViewControllerSections.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SetupStudentsViewControllerSections(rawValue: section)! {
        case .numberOfStudents:
            return 1
        case .fieldsDistribution:
            return studentSetup?.fieldsDistribution.count ?? 0
        case .categoriesDistribution:
            return studentSetup?.categoriesDistribution.count ?? 0
        }
    }


}
