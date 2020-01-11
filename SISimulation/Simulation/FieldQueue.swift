//
//  FieldQueue.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

final class FieldQueue: Queue<Student>,
    TimeDependable {

    let field: Field

    // MARK: - TimeDependable

    let timer = SimulationTimer()

    // MARK: - init

    init(field: Field) {
        self.field = field
    }
}
