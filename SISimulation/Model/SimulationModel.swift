//
//  SimulationModel.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

final class SimulationModel {

    private(set) var queues = [FieldQueue]()

    init(students: [Student]) {
        queues = Field.allCases.map { FieldQueue(field: $0) }
    }


}
