//
//  MainNetworkServiceUseCase.swift
//  ReactiveProject
//
//  Created by Dmitry Kononov on 5.12.24.
//

import Foundation
import DIYReactive

struct MainNetworkServiceUseCase: MainNetworkServiceProtocol {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getRandomFact() -> RxPublisher<String> {
        networkService.getRandomFact()
    }
    
    
}
