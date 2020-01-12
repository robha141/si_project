//
//  Array+Extension.swift
//  SISimulation
//
//  Created by Róbert Oravec on 12/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import Foundation

extension Array where Element == Double {
    func randomEnumElement<T>(of type: T.Type) -> T where T: RawRepresentable, T.RawValue == Int {
        let number = randomNumber()
        guard let value = T(rawValue: number) else { fatalError("💥 Not valid enum case for \(number)") }
        return value
    }

    func randomNumber() -> Int {
        let sum = reduce(0, +)
        let random = Double.random(in: 0 ..< sum)
        var accum = 0.0
        for (i, p) in enumerated() {
            accum += p
            if random < accum {
                return i
            }
        }
        return count - 1
    }
}
