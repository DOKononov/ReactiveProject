//
//  DIConfigurator.swift
//  ReactiveProject
//
//  Created by Dmitry Kononov on 5.12.24.
//

import Foundation

final class DIConfigurator {
    private init() {}
    
    static func configue() -> Container {
        let container = Container()
        container.register(dependency: NetworkService())
        
        return container
    }
}
