//
//  StudentSetup.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

enum StudentSetupError: Error {
    case notEnoughStudents
    case fieldsAreNotDistributedCorrectly
    case categoriesNotDistributedCorrectly(field: Field)
    case wrongPercetage

    var localizedDescription: String {
        switch self {
        case .notEnoughStudents:
            return "Number of students has to be > 10"
        case .fieldsAreNotDistributedCorrectly:
            return "Fields distribution count != 100"
        case let .categoriesNotDistributedCorrectly(field: field):
            return "Categories distribution count in \(field.title) != 100"
        case .wrongPercetage:
            return "Wrong student percentage (should be int between 0 ... 100)"
        }
    }
}

/// Class which holds students percetage distribution.
final class StudentSetup {

    // MARK: - properties

    var numberOfStudents = 100
    var mistakeSance: Double = 5
    var arriveSance: Double = 1
    var distributions: [FieldDistribution]

    // MARK: - init

    init() {
        distributions = Field.allCases.map {
            FieldDistribution(
                field: $0,
                distribution: $0.baseDistribution,
                categoriesDistribution: $0.categories.map {
                    CategoryDistribution(category: $0, distribution: $0.baseDistribution)
                }
            )
        }
    }

    // MARK: - student generation

    func generateStudents() -> [Student] {
        return StudentFactory(
            distributions: distributions,
            numberOfStudents: numberOfStudents
        ).makeStudents()
    }

    // MARK: - evaluating values

    func evaluateValues() throws {
        guard numberOfStudents > 10 else { throw StudentSetupError.notEnoughStudents }
        let fieldsDistributionCount = distributions.reduce(0) { $0 + $1.distribution }
        guard fieldsDistributionCount == 100 else { throw StudentSetupError.fieldsAreNotDistributedCorrectly }
        try distributions.forEach {
            let categoriesDistributionCount = $0.categoriesDistribution.reduce(0, { $0 + $1.distribution })
            if categoriesDistributionCount != 100 {
                throw StudentSetupError.categoriesNotDistributedCorrectly(field: $0.field)
            }
        }
    }

    func evaluatePercentage(from text: String?) throws -> Double {
        guard let number = Double(text ?? "0.0"),
            0...100 ~= number else { throw StudentSetupError.wrongPercetage }
        return number
    }
}
