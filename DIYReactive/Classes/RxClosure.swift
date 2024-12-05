//
//  RxClosure.swift
//  DIYReactive
//
//  Created by Dmitry Kononov on 21.11.24.
//

import Foundation

class RxClosure<T: Any>: Equatable {
    private let id = UUID()
    let body: (T) -> Void
    let errorBody: ((Error) -> Void)?
    
    init(
        body: @escaping (T) -> Void,
        errorBody: ((Error) -> Void)? = nil
    ) {
        self.body = body
        self.errorBody = errorBody
    }
    
    static func == (lhs: RxClosure<T>, rhs: RxClosure<T>) -> Bool {
        return lhs.id == rhs.id
    }
}
