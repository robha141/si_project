//
//  CrowdedPerception.swift
//  SISimulation
//
//  Created by Róbert Oravec on 12/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

enum CrowdedPerception: Int {
    case seven
    case eight
    case nine

    var numberOfPeople: Int {
        switch self {
        case .seven:
            return 7
        case .eight:
            return 8
        case .nine:
            return 9
        }
    }

    func isQueueFull(queue: FieldQueue) -> Bool {
        return queue.numberOfElemets > rawValue
    }

    /// Every student has his own perception of how crowded is inside, we can determine if he will move from outside queue or not.
    static func getRandom() -> CrowdedPerception {
        return [35, 35, 30].randomEnumElement(of: CrowdedPerception.self)
    }
}
