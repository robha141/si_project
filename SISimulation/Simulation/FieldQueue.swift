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
    TimeDependable {

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

    func update() {
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

    // MARK: - student handling

    func addStudentToWaitingQueue(student: Student) {
        insert(element: student)
    }
}
