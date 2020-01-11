//
//  Category.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import Foundation

enum Category {
    case category1
    case category2

    var title: String {
        switch self {
        case .category1:
            return "Category 1"
        case .category2:
            return "Category 2"
        }
    }

    var baseDistribution: Int {
        switch self {
        case .category1:
            return 50
        case .category2:
            return 50
        }
    }

    /// Time to solve problem in minutes. Value should return predetermined value + random generated  value.
    var timeToSolve: Int {
        return 2 + 1.randomLimitedValue()
    }
}
