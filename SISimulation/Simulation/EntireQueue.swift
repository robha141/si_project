//
//  EntireQueue.swift
//  SISimulation
//
//  Created by Róbert Oravec on 12/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import Foundation

final class EntireQueue {

    // MARK: - properties

    private(set) var outsideQueue = WaitingQueue()
    private(set) var queues = [FieldQueue]()

    // MARK: - init

    init() {
        self.queues = Field.allCases.map {
            FieldQueue(
                field: $0,
                onWrongStudentReceive: { [unowned self] in
                    $0.goToCorrectQueue(in: self.queues)
                }
            )
        }
    }

    // MARL: - update

    func update() {
        updateWaitingQueue()
        queues.updateTime()
    }

    func studentCame(student: Student) {
        student.startStandingInQueue()
        guard outsideQueue.isEmpty else {
            return outsideQueue.addStudentToQueue(student: student)
        }
        let queue = queues.getQueue(according: student.goingToField)
        guard !student.crowdedPerception.isQueueFull(queue: queue) else { return }
        queue.addStudentToQueue(student: student)
    }

    private func updateWaitingQueue() {
        guard let firstStudent = outsideQueue.topElement else { return }
        let queue = queues.getQueue(according: firstStudent.goingToField)
        guard !firstStudent.crowdedPerception.isQueueFull(queue: queue) else { return }
        queue.addStudentToQueue(student: outsideQueue.popFirst()!)
    }
}
