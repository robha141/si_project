//
//  Simulation.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

final class Simulation {

    // MARK: - properties

    private var students: [Student]
    private let usePanel: Bool
    private var shouldSimulate = true



    // MARK: - init

    init(students: [Student],
         panelInUse: Bool) {
        self.students = students
        self.usePanel = panelInUse
        // Create queue
    }

    // MARK: - loop

    func simulate(onComplete: () -> Void) {
        while shouldSimulate {

        }
    }

    // MARK: - simulation time

    private func updateTimeDependables() {
        
    }
}
