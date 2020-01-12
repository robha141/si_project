//
//  StudentQueue.swift
//  SISimulation
//
//  Created by Róbert Oravec on 12/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import Foundation

protocol StudentQueue {
    func addStudentToQueue(student: Student)
}

extension StudentQueue where Self: Queue<Student> {
    func addStudentToQueue(student: Student) {
        insert(element: student)
    }
}
