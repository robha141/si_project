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
    /// Time to solve student's problem in minutes. Some random value will be added according problem category.
    let timeToSolveProblem: Int
    /// Total waiting time in minutes
    private(set) var totalWaitingTime: Double?
    var timer = SimulationTimer()

    // MARK: - init

    init(studyField: Field, problem: Category) {
        self.studyField = studyField
        self.problem = problem
    }

    /// Function should be called, if rector starts solve problem with student.
    func startSolvingProblem() {
        totalWaitingTime = Double(timer.elapsedSeconds) / 60
    }
}
