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

    private var setup: StudentSetup
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

    private var numberOfArrivedStudents = 0
    private let numberOfStutentsInQueue: Int
    private let usePanel: Bool
    private var shouldSimulate = true
    private var shouldGenerateStudents = true
    private let panel = Panel()

    /// Duration of simulation in minutes
    private let duration = 60

    // MARK: - init

    /// Duration is in minutes, default is 60
    init(studentSetup: StudentSetup,
         panelInUse: Bool,
         duration: Int = 60) {
        self.setup = studentSetup
        self.students = studentSetup.generateStudents()
        self.students.shuffle()
        self.usePanel = panelInUse
        self.numberOfStutentsInQueue = students.count
    }

    // MARK: - loop

    /// Simulation loop is performed on background thred (qos userInteractive).
    func simulate(onComplete: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
            if self.usePanel {
                self.students.forEach { self.panel.calculateWaitingTime(for: $0) }
            }
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
        guard shouldGenerateStudents,
            isStudentGenerated() else { return }
        let student = setup.generateRandomStudent()
        if usePanel {
            self.panel.calculateWaitingTime(for: student)
        }
        numberOfArrivedStudents += 1
        students.append(student)
    }

    private func isStudentGenerated() -> Bool {
        return [setup.arriveSance, 100 - setup.arriveSance]
            .randomNumber() == 0
    }

    /// Tick on every time dependable object.
    private func updateTimeDependables() {
        queue.update()
        students.updateTime {
            if $0.state == .waiting, $0.timeToGoToQueue <= SimulationTimer.totalMinutes {
                queue.studentCame(student: $0)
            }
        }
    }

    // MARK: - Simulation end condition

    private func controlIfStudentsShouldBeGenerated() {
        shouldGenerateStudents = SimulationTimer.totalMinutes < duration
    }

    private func controlIfSimulationShouldEnd() {
        shouldSimulate = doneStudents.count != students.count
    }

    // MARK: - get result

    func makeResultItems() -> [SimulationResultItem] {
        let numberOfStudents = students.count
        let waitingTimes = students.compactMap { $0.totalWaitingTime }
        let totalWaitingTime = waitingTimes
            .reduce(0, +)
        let averageWaitingTime = totalWaitingTime / Double(numberOfStudents)
        let highestWaitingTime = waitingTimes.max() ?? -1.0
        let lowestWaitingTime = waitingTimes.min() ?? -1.0
        return [
            SimulationResultItem(name: "Number of students", value: "\(numberOfStutentsInQueue)"),
            SimulationResultItem(name: "Number of arrived students", value: "\(numberOfArrivedStudents)"),
            SimulationResultItem(name: "Average wating time (min)", value: "\(averageWaitingTime)"),
            SimulationResultItem(name: "Higest waiting time (min)", value: "\(highestWaitingTime)"),
            SimulationResultItem(name: "Lowest wating time (min)", value: "\(lowestWaitingTime)")
        ]
    }
}
