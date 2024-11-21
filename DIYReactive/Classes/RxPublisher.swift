//
//  RxPublisher.swift
//  DIYReactive
//
//  Created by Dmitry Kononov on 21.11.24.
//

import Foundation

public class RxPublisher<T: Any> {
    
    private var subscribers: [RxClosure<T>] = []
    
    public init() { }
    
    public func subscribe(_ handler: @escaping (T) -> Void) -> RxReleasable {
        let closure = RxClosure(body: handler)
        subscribers.append(closure)
        
        return RxReleasable { [weak self] in
            self?.subscribers.removeAll(where: { closure == $0 })
        }
    }
    
    public func send(event: T) {
        subscribers.forEach { $0.body(event) }
    }
}
