//
//  TimeDependable.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

protocol TimeDependable: class {
    var timer: SimulationTimer { get set }
}

extension Array where Element: TimeDependable {
    func updateTime() {
        forEach { $0.timer.tick() }
    }
}
