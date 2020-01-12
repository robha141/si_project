//
//  SimulationViewController.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import UIKit

final class SimulationViewConttoller: UITableViewController {

    // MARK: - properties

    var simulation: Simulation?
    private var simulationResult = [SimulationResultItem]()
    private let cellId = "ResultCell"

    // MARK: - lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let simulation = simulation else { fatalError("💥 Simulation should be set") }
        makeLoadingOverlay()
        simulation.simulate { [unowned self] in
            self.simulationDone()
        }
    }

    // MARK: - simulation done handle

    private func simulationDone() {
        dismissLoadingOverlay()
        simulationResult = simulation!.makeResultItems()
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simulationResult.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let item = simulationResult[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.value
        cell.detailTextLabel?.textColor = .systemBlue
        return cell
    }
}
