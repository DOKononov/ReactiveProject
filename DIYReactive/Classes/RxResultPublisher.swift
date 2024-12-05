//
//  RxResultPublisher.swift
//  DIYReactive
//
//  Created by Dmitry Kononov on 4.12.24.
//

import Foundation

public class RxResultPublisher<T: Any> {
    
    public typealias ResultClosure = (Result<T, Error>) -> Void
    
    public static func create(
        _ builder: (@escaping ResultClosure) -> Void
    ) -> RxPublisher<T> {
        let publisher = RxPublisher<T>()
        
        let resultsClosure: (Result<T, Error>) -> Void = { result in
            switch result {
            case .success(let event): publisher.send(final: event)
            case .failure(let error): publisher.send(error: error)
            }
        }
        
        builder(resultsClosure)
        
        return publisher
    }
}
