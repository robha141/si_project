//
//  Queue.swift
//  SISimulation
//
//  Created by Róbert Oravec on 11/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

class Queue<T> {

    // MARK: - properties

    private var elements = [T]()

    // MARK: - functions

    func insert(element: T) {
        elements.append(element)
    }

    func popFirst() -> T? {
        guard !elements.isEmpty else { return nil }
        return elements.removeFirst()
    }
}
