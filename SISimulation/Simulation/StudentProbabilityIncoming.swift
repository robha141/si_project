//
//  StudentProbabilityIncoming.swift
//  SISimulation
//
//  Created by Róbert Oravec on 23/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import Foundation

enum StudentProbabilityIncoming {
    case firstStage
    case secondStage
    case thirdStage
    case fourthStage
    case notGenerate

    init(elapsedMinutes: Int, duration: Int) {
        let time: Double = elapsedMinutes >= duration
            ? 1.0
            : Double(elapsedMinutes) / Double(duration)
        switch time {
        case 1.0:
            self = .notGenerate
        case let x where x >= 0.9:
            self = .fourthStage
        case let x where x >= 0.7:
            self = .thirdStage
        case let x where x >= 0.4:
            self = .secondStage
        default:
            self = .firstStage
        }
    }
}
