//
//  StudentFactory.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

struct StudentFactory {
    let distributions: [FieldDistribution]
    let numberOfStudents: Int

    func makeStudents() -> [Student] {
        return distributions.map { (numberOfStudentsForField(field: $0), $0) }
            .flatMap { studentsAccordingField(numberOfStudentsInField: $0.0, fieldDistribution: $0.1) }
    }

    private func numberOfStudentsForField(field: FieldDistribution) -> Int {
        return numberOfStudents * (field.distribution / 100)
    }

    private func studentsAccordingField(numberOfStudentsInField: Int,
                                fieldDistribution: FieldDistribution) -> [Student] {
        return fieldDistribution.categoriesDistribution
            .map { (numberOfStudentsInField * ($0.distribution / 100), $0.category) }
            .flatMap { createStudents(numberOfStudents: $0.0, category: $0.1, field: fieldDistribution.field) }
    }

    private func createStudents(numberOfStudents: Int,
                        category: Category,
                        field: Field) -> [Student] {
        return (0 ..< numberOfStudents).map { _ in Student(studyField: field, problem: category) }
    }
}
