//
//  WaitingQueue.swift
//  SISimulation
//
//  Created by Róbert Oravec on 12/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import Foundation

final class WaitingQueue: Queue<Student>,
    TimeDependable,
    StudentQueue {

    var timer = SimulationTimer() {
        didSet { moveQueue() }
    }

    private func moveQueue() {
        
    }
}
