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
        let vm = MainVM(networkService: MainNetworkServiceUseCase(networkService: container.resolve()))
        let vc = MainVC(viewModel: vm)
        return vc
    }
}
