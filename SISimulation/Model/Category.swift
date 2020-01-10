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
        return "TODO: - make title for category \(self)"
    }

    var baseDistribution: Int {
        switch self {
        case .category1:
            return 50
        case .category2:
            return 50
        }
    }
}
