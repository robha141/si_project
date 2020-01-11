//
//  FieldQueue.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

final class FieldQueue: Queue<Student>,
    TimeDependable {

    let field: Field
    private var student: Student?
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

    }

    // MARK: - student handling

    func addStudentToWaitingQueue(student: Student) {
        insert(element: student)
    }
}
