//
//  StudentSetup.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

typealias ItemDistribution<T> = (item: T, distribution: Double)

/// Class which holds students percetage distribution.
final class StudentSetup {

    // MARK: - properties

    var numberOfStudents = 100

    var fieldsDistribution = [
        ItemDistribution<Field>(.finance, 20.0),
        ItemDistribution<Field>(.cestovnyRuch, 20.0),
        ItemDistribution<Field>(.ekonomickaInformatika, 45.0),
        ItemDistribution<Field>(.zahranicniStudenti, 15.0)
    ]

    var categoriesDistribution = [
        ItemDistribution<Category>(.category1, 50.0),
        ItemDistribution<Category>(.category2, 50.0)
    ]

    // MARK: - student generation

    func generateStudents() throws -> [Student] {
        fatalError("Not implemented")
    }
}
