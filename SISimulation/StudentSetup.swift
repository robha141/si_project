//
//  StudentSetup.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

/// Class which holds students percetage distribution.
final class StudentSetup {

    // MARK: - properties

    var numberOfStudents = 100

    var distributions: [FieldDistribution]

    // MARK: - init

    init() {
        distributions = Field.allCases.map {
            FieldDistribution(
                field: $0,
                distribution: $0.baseDistribution,
                categoriesDistribution: $0.categories.map {
                    CategoryDistribution(category: $0, distribution: 0)
                }
            )
        }
    }

    // MARK: - student generation

    func generateStudents() -> [Student] {
        // Generate students acoording number and distribution.
        // Round number of students up / down
        // More logic will be added for "zahranicniStudenti",
        fatalError("Not implemented")
    }

    func evaluateValues() throws {
        // If distribution is not 100, throw an error
    }
}
