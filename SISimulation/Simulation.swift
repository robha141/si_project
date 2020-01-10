//
//  Simulation.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

final class Simulation {
    private var students: [Student]
    private var usePanel: Bool

    init(students: [Student],
         panelInUse: Bool) {
        self.students = students
        self.usePanel = panelInUse
    }
}
