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
    /// Updates time for each element. Aditionaly, we can make custom changes to element inside closure.
    func updateTime(update: (Element) -> Void = { _ in }) {
        forEach {
            $0.timer.tick()
            update($0)
        }
    }
}
