//
//  IntSpawner.swift
//  ReactiveProject
//
//  Created by Dmitry Kononov on 21.11.24.
//

import Foundation
import DIYReactive

final class IntSpawner {
    static let shared = IntSpawner()
    var intDidSpawn: RxPublisher<Int>

    private init() {
        self.intDidSpawn = RxPublisher()
        timer.fire()
    }
    
    private lazy var timer: Timer = Timer.scheduledTimer(withTimeInterval: 5,
                                                          repeats: true) { _ in
        let randomInt = Int.random(in: Int.min...Int.max)
        self.intDidSpawn.send(event: randomInt)
    }
    
}
