//
//  Container.swift
//  ReactiveProject
//
//  Created by Dmitry Kononov on 5.12.24.
//

import Foundation

final class Container {
    private var deps: [String: Any] = [ : ]
    
    func register<T: Any>(dependency: T) {
        deps["\(T.self)"] = dependency
    }
    
    func resolve<T: Any>() -> T {
        return deps["\(T.self)"] as! T
    }
}
