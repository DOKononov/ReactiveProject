//
//  RxValuePublisher.swift
//  DIYReactive
//
//  Created by Dmitry Kononov on 21.11.24.
//

import Foundation


final class RxValuePublisher<T: Any>: RxPublisher<T> {
    public var value: T
    
    init(initialValue: T) {
        self.value = initialValue
    }
    
    override func send(event: T) {
        self.value = event
        super.send(event: event)
    }
    
    override func subscribe(_ handler: @escaping (T) -> Void) -> RxReleasable {
        handler(value)
        return super.subscribe(handler)
    }
    
}
