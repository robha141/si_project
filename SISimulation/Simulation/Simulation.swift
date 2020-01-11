//
//  Simulation.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import Foundation

final class Simulation {

    // MARK: - properties

    private var queues = [FieldQueue]()
    private var students: [Student]

    private let usePanel: Bool
    private var shouldSimulate = true
    private var shouldGenerateStudents = true

    /// Current simulation time in seconds
    private var simulationTime = 0
    /// Duration of simulation in minutes
    private let duration = 60


    // MARK: - init

    /// Duration is in minutes, default is 60
    init(students: [Student],
         panelInUse: Bool,
         duration: Int = 60) {
        self.students = students
        self.usePanel = panelInUse
        self.queues = Field.allCases.map {
            FieldQueue(
                field: $0,
                onWrongStudentReceive: { [unowned self] in
                    self.sendStudentToCorrectQueue(student: $0)
                }
            )
        }
    }

    // MARK: - loop

    /// Simulation loop is performed on background thred.
    func simulate(onComplete: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
            while self.shouldSimulate {

            }
            DispatchQueue.main.async {
                onComplete()
            }
        }
    }

    // MARK: - simulation time

    private func updateTimeDependables() {
        
    }

    // MARK: - helping functions

    private func sendStudentToCorrectQueue(student: Student) {
        queues.first(where: { $0.field == student.studyField })?.addStudentToWaitingQueue(student: student)
    }

    /// When simulationTime == duration (after conversion), stop generatingStudents
    private func controlIfSimulationShouldEnd() {

    }
}
