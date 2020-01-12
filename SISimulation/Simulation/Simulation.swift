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

    private var outsideQueue = Queue<Student>()
    private var queues = [FieldQueue]()
    private var students: [Student]

    private let usePanel: Bool
    private var shouldSimulate = true
    private var shouldGenerateStudents = true

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
                    $0.goToCorrectQueue(in: self.queues)
                }
            )
        }
    }

    /// Sort students to queue according panel condition.
    private func initialQueueSetup() {

    }

    // MARK: - loop

    /// Simulation loop is performed on background thred (qos userInteractive).
    func simulate(onComplete: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
            while self.shouldSimulate {
                SimulationTimer.totalSeconds += 1
                self.updateTimeDependables()
                self.generateAnotherStudentToQueue()
                self.controlIfStudentsShouldBeGenerated()
                self.controlIfSimulationShouldEnd()
            }
            DispatchQueue.main.async {
                onComplete()
            }
        }
    }

    // MARK: - Time updates

    private func generateAnotherStudentToQueue() {
        guard shouldGenerateStudents else { return }
    }

    /// Tick on every time dependable object.
    private func updateTimeDependables() {
        [students, queues]
            .compactMap { return $0 as? TimeDependable }
            .forEach { $0.timer.tick() }
    }

    // MARK: - Simulation end condition

    private func controlIfStudentsShouldBeGenerated() {
        shouldGenerateStudents = SimulationTimer.totalMinutes < duration
    }

    private func controlIfSimulationShouldEnd() {
        shouldSimulate = students.contains(where: { $0.problemSolved == false })
    }
}
