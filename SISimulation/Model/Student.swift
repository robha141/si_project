//
//  Student.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

enum StudentMistake: Int {
    case mistaken
    case notMistaken

    /// Mistake sance should be value between 100 and 0
    static func getRandom(mistakeSance: Double) -> StudentMistake {
        let supplement = 100.0 - mistakeSance
        return [mistakeSance, supplement].randomEnumElement(of: StudentMistake.self)
    }
}

enum CrowdedPerception: Int {
    case seven
    case eight
    case nein

    var numberOfPeople: Int {
        switch self {
        case .seven:
            return 7
        case .eight:
            return 8
        case .nein:
            return 9
        }
    }

    func isQueueFull(queue: FieldQueue) -> Bool {
        return queue.numberOfElemets >= rawValue
    }

    /// Every student has his own perception of how crowded is inside, we can determine if he will move from outside queue or not.
    static func getRandom() -> CrowdedPerception {
        return [35, 35, 30].randomEnumElement(of: CrowdedPerception.self)
    }
}

final class Student: TimeDependable {

    // MARK: - properties

    /// Real field, which is student studying.
    let studyField: Field
    /// Field, to which is student going.
    let goingToField: Field
    let crowdedPerception: CrowdedPerception
    let problem: Category
    private(set) var problemSolved = false
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
        totalWaitingTime = Double(timer.elapsedSeconds) / 60
    }

    func problemWasSolved() {
        problemSolved = true
    }

    /// Randomly assigns student to queue, when his time is up.
    func goToQueue(waitingQueue: WaitingQueue,
                   queues: [FieldQueue]) {
        timer.resetElapsed()
        // When people are waiting outside, student always go to waiting queue.
        guard waitingQueue.isEmpty else { return waitingQueue.addStudentToQueue(student: self) }
        // When nobody waits outside, student will check, if there is not too crowded inside for his field.
        // In our case, we will check, if queue is full, which means, there are few people standing.
        // We will determine this value randomly using `FullQueueThresholds`.
        let queue = queues.getQueue(according: goingToField)
        guard !crowdedPerception.isQueueFull(queue: queue) else {
            return waitingQueue.addStudentToQueue(student: self)
        }
        queue.addStudentToQueue(student: self)
    }

    /// When student is in wrong queue, it will be send to correct one (according studyField).
    func goToCorrectQueue(in queues: [FieldQueue]) {
        queues.getQueue(according: studyField)
            .addStudentToQueue(student: self)
    }
}
