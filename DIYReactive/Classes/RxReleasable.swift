//
//  RxReleasable.swift
//  DIYReactive
//
//  Created by Dmitry Kononov on 21.11.24.
//

import Foundation

public class RxReleasable {
    
    private let releaseHandler: () -> Void
    
    init(releaseHandler: @escaping () -> Void) {
        self.releaseHandler = releaseHandler
    }
    
    public func store(in bag: inout [RxReleasable]) {
        bag.append(self)
    }
    
    deinit { releaseHandler() }
}
