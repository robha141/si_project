//
//  Field.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import Foundation

enum Field: Int, CaseIterable {
    case finance
    case cestovnyRuch
    case ekonomickaInformatika
    case zahranicniStudenti

    var title: String {
        return "TODO: - make title for field \(self)"
    }

    var categories: [Category] {
        return [.category1, .category2]
    }

    var baseDistribution: Int {
        switch self {
        case .finance:
            return 20
        case .cestovnyRuch:
            return 20
        case .ekonomickaInformatika:
            return 45
        case .zahranicniStudenti:
            return 15
        }
    }
}
