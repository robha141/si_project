//
//  FieldQueue.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

private enum FieldQueueState {
    case emptyRoom
    case studentInRoom(student: Student)
}

final class FieldQueue: Queue<Student>,
    TimeDependable,
    StudentQueue {

    let field: Field
    private var state: FieldQueueState = .emptyRoom
    private let onWrongStudentReceive: (Student) -> Void

    // MARK: - TimeDependable

    var timer = SimulationTimer() {
        didSet { update() }
    }

    // MARK: - init

    init(field: Field,
         onWrongStudentReceive: @escaping (Student) -> Void) {
        self.field = field
        self.onWrongStudentReceive = onWrongStudentReceive
    }

    private func update() {
        switch state {
        case .emptyRoom:
            acceptStudent()
        case let .studentInRoom(student: student):
            solveStudentProblem(student: student)
        }
    }

    private func acceptStudent() {
        guard let student = popFirst() else { return state = .emptyRoom }
        guard student.studyField == field else { return onWrongStudentReceive(student) }
        timer.resetElapsed()
        student.startSolvingProblem()
        state = .studentInRoom(student: student)
    }

    private func solveStudentProblem(student: Student) {
        guard student.timeToSolveProblem >= timer.elapsedMinutes else { return }
        student.problemWasSolved()
        state = .emptyRoom
    }
}

extension Array where Element == FieldQueue {
    func getQueue(according: Field) -> FieldQueue {
        guard let queue = first(where: { $0.field == according }) else {
            fatalError("💥 All Queues should be inside array")
        }
        return queue
    }

    func getRandomQueue(except: Field) -> FieldQueue {
        let filtered = filter { $0.field != except }
        guard let queue = filtered.randomElement() else {
            fatalError("💥 Filtered array should never be empty")
        }
        return queue
    }
}
