//
//  StudentMistake.swift
//  SISimulation
//
//  Created by Róbert Oravec on 12/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

enum StudentMistake: Int {
    case mistaken
    case notMistaken

    /// Mistake sance should be value between 100 and 0
    static func getRandom(mistakeSance: Double) -> StudentMistake {
        let supplement = 100.0 - mistakeSance
        return [mistakeSance, supplement].randomEnumElement(of: StudentMistake.self)
    }
}
