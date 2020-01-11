//
//  Int+Extension.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import Foundation

extension Int {
    func randomLimitedValue() -> Int {
        return Int.random(in: -self ... self)
    }
}
