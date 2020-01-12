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

    private var queue = EntireQueue()

    private var students: [Student]
    private var waitingStudents: [Student] {
        return students.filter { $0.state == .waiting }
    }
    private var doneStudents: [Student] {
        return students.filter { $0.state == .problemSolved }
    }
    private var waitingInQueueStudents: [Student] {
        return students.filter { $0.state == .waitingInQueue }
    }

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
        queue.update()
        students.updateTime()
    }

    // MARK: - Simulation end condition

    private func controlIfStudentsShouldBeGenerated() {
        shouldGenerateStudents = SimulationTimer.totalMinutes < duration
    }

    private func controlIfSimulationShouldEnd() {
        shouldSimulate = doneStudents.count != students.count
    }
}
