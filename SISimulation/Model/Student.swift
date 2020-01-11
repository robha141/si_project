//
//  Student.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

final class Student: TimeDependable {

    // MARK: - properties

    let studyField: Field
    let problem: Category

    // MARK: - TimeDependable

    var timer = SimulationTimer()

    // MARK: - init

    init(studyField: Field, problem: Category) {
        self.studyField = studyField
        self.problem = problem
    }
}
