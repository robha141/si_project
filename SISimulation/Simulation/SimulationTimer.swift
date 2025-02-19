//
//  SimulationTimer.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

struct SimulationTimer {

    // MARK: - properties

    static var totalSeconds = 0
    static var totalMinutes: Int {
        return totalSeconds / 60
    }
    private(set) var elapsedSeconds = 0
    private(set) var elapsedMinutes = 0

    // MARK: - functions

    mutating func tick() {
        elapsedSeconds += 1
        guard elapsedSeconds % 60 == 0 else { return }
        elapsedMinutes += 1
    }

    mutating func resetElapsed() {
        elapsedSeconds = 0
        elapsedMinutes = 0
    }
}
