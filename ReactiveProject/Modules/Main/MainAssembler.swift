//
//  MainAssembler.swift
//  ReactiveProject
//
//  Created by Dmitry Kononov on 4.12.24.
//

import UIKit

final class MainAssembler {
    private init() {}
    
    static func make(container: Container) -> UIViewController {
        let router = MainRouter(container: container)
        let vm = MainVM(networkService: MainNetworkServiceUseCase(networkService: container.resolve()), router: router)
        let vc = MainVC(viewModel: vm)
        router.root = vc
        return vc
    }
}
