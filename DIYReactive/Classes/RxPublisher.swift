//
//  RxPublisher.swift
//  DIYReactive
//
//  Created by Dmitry Kononov on 21.11.24.
//

import Foundation

public class RxPublisher<T: Any> {
    
    public enum QueueType {
        case async
        case sync
    }
    
    private var subscribers: [RxClosure<T>] = []
    
    public init() { }
    private var bag: [RxReleasable] = []
    
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
    
    public func filter(_ handler: @escaping (T) -> Bool) -> RxPublisher<T> {
        let filteredPublisher = RxPublisher<T>()
        self.subscribe { event in
                if handler(event) {
                    filteredPublisher.send(event: event)
                }
            }.store(in: &bag)
        
        return filteredPublisher
    }
    
    public func map<MapType>(_ handler: @escaping (T) -> MapType) -> RxPublisher<MapType> {
        let mapPublisher = RxPublisher<MapType>()
        self.subscribe { event in
            let mappedValue = handler(event)
            mapPublisher.send(event: mappedValue)
        }.store(in: &bag)
        return mapPublisher
    }
    
    public func merge(_ publishers: RxPublisher<T>...) -> RxPublisher<T> {
            let mergePublisher = RxPublisher<T>()
            let allPublishers = publishers + [self]
            allPublishers.forEach { publisher in
                bag.append(
                    publisher.subscribe { event in
                        mergePublisher.send(event: event)
                    }
                )
            }
            return mergePublisher
        }

    public func observOn(_ queue: DispatchQueue, type: QueueType) -> RxPublisher<T> {
        let queuePublisher = RxPublisher<T>()
        queuePublisher.subscribe { event in
            switch type {
            case .async:
                queue.async {
                    queuePublisher.send(event: event)
                }
            case .sync:
                queue.sync {
                    queuePublisher.send(event: event)
                }
            }

        }.store(in: &bag)
        return queuePublisher
    }
}
