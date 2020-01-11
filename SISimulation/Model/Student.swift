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
    private(set) var problemSolved = false
    /// Time to solve student's problem in minutes.
    let timeToSolveProblem: Int
    /// Total waiting time in minutes.
    private(set) var totalWaitingTime: Double?
    var timer = SimulationTimer() {
        didSet { update() }
    }
    private var queueEnterTime = 0

    // MARK: - init

    init(studyField: Field, problem: Category) {
        self.studyField = studyField
        self.problem = problem
        self.timeToSolveProblem = problem.timeToSolve
    }

    private func update() {

    }

    /// Function should be called, if rector starts solve problem with student.
    func startSolvingProblem() {
        totalWaitingTime = Double(timer.elapsedSeconds) / 60
    }

    func problemWasSolved() {
        problemSolved = true
    }

    /// Randomly assigns student to queue, when his time is up.
    func goToQueue(outsideQueue: Queue<Student>,
                   queues: FieldQueue) {

    }

    /// When student is in wrong queue, it will be send to correct one (according studyField).
    func goToCorrectQueue(in queues: [FieldQueue]) {
        queues.first(where: { $0.field == studyField })?.addStudentToWaitingQueue(student: self)
    }
}
