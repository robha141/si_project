//
//  Panel.swift
//  SISimulation
//
//  Created by Róbert Oravec on 12/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

final class Panel: TimeDependable {

    // MARK: - properties

    private var schedule = [Field: Int]()
    var timer = SimulationTimer()

    init() {
        schedule = Dictionary(uniqueKeysWithValues: Field.allCases.map { ($0, 0) })
    }

    // MARK: - waiting time

    /// Calculate waiting time according schedule. Function will assign time, when will student enter queue.
    func calculateWaitingTime(for student: Student) {
        guard let lastRecord = schedule[student.studyField] else { return }
        let calculatedTime = lastRecord == 0 ? 0 : lastRecord + 1
        schedule[student.studyField] = calculatedTime + student.timeToSolveProblem
        student.getTicketWithTime(timeToGo: calculatedTime)
    }
}
