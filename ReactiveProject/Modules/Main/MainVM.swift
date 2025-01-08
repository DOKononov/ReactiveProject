//
//  MainVM.swift
//  ReactiveProject
//
//  Created by Dmitry Kononov on 4.12.24.
//

import Foundation
import DIYReactive

protocol MainNetworkServiceProtocol {
    func getRandomFact() -> RxPublisher<String>
}

protocol MainRouterProtocol {
    func openAlert(message: String)
    func openBreedListModule()
}


final class MainVM: MainViewModelProtocol {
    //In
    var tapOnGenerate: RxPublisher<Void> = .init()
    //Out
    var didReciveFact: RxPublisher<String> = .init()
    
    private let networkService: MainNetworkServiceProtocol
    private var bag: [RxReleasable] = []
    
    private let router: MainRouterProtocol
    
    init(networkService: MainNetworkServiceProtocol, 
         router: MainRouterProtocol
    ) {
        self.networkService = networkService
        self.router = router
        bind()
    }
    
    private func bind() {
        tapOnGenerate.subscribe { [weak self] _ in
            self?.loadFact()
        }.store(in: &bag)
    }
    
    private func loadFact() {
        networkService.getRandomFact()
            .observOn(.main)
            .subscribe(
                onSuccess: { [weak self] fact in
                self?.didReciveFact.send(event: fact)
            }, 
                onError: { error in
                    print("[Error]", error.localizedDescription)
            }
            )
            .store(in: &bag)
    }
    
    
}
