//
//  SimulationViewController.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import UIKit

final class SimulationViewConttoller: UIViewController {

    // MARK: - properties

    var simulation: Simulation?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let simulation = simulation else { fatalError("💥 Simulation should be set") }
        simulation.simulate {
            print("Simulation done")
        }
    }

}
