//
//  Student.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

final class Student: TimeDependable {

    // MARK: - properties

    /// Real field, which is student studying.
    let studyField: Field
    /// Field, to which is student going.
    let goingToField: Field
    let crowdedPerception: CrowdedPerception
    let problem: Category
    var state: StudentState = .waiting {
        didSet {
            switch state {
            case .waitingInQueue:
                timer.resetElapsed()
            case .solvingProblem:
                totalWaitingTime = Double(timer.elapsedSeconds) / 60
            default:
                break
            }
        }
    }
    /// Time to solve student's problem in minutes.
    let timeToSolveProblem: Int
    /// Total waiting time in minutes.
    private(set) var totalWaitingTime: Double?
    var timer = SimulationTimer()

    // MARK: - init

    init(studyField: Field,
         problem: Category,
         mistakeSance: Double) {
        self.studyField = studyField
        self.problem = problem
        self.timeToSolveProblem = problem.timeToSolve
        switch StudentMistake.getRandom(mistakeSance: mistakeSance) {
        case .notMistaken:
            goingToField = studyField
        case .mistaken:
            goingToField = Field.allCases
                .filter { $0 != studyField }
                .randomElement()!
        }
        self.crowdedPerception = CrowdedPerception.getRandom()
    }

    /// Function should be called, if rector starts solve problem with student.
    func startSolvingProblem() {
        state = .solvingProblem
    }

    func problemWasSolved() {
        state = .problemSolved
    }

    /// Randomly assigns student to queue, when his time is up.
    func startStandingInQueue() {
        state = .waitingInQueue
    }

    /// When student is in wrong queue, it will be send to correct one (according studyField).
    func goToCorrectQueue(in queues: [FieldQueue]) {
        queues.getQueue(according: studyField)
            .addStudentToQueue(student: self)
    }
}
