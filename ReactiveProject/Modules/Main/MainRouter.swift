//
//  MainRouter.swift
//  ReactiveProject
//
//  Created by Dmitry Kononov on 3.01.25.
//

import UIKit
 
final class MainRouter: MainRouterProtocol {
    
    weak var root: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func openAlert(message: String) {
        let vc = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction.init(title: "Ok", style: .default))
        root?.present(vc, animated: true)
    }
    
    func openBreedListModule() {
        let vc = MainAssembler.make(container: container)
        root?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        root?.dismiss(animated: true)
    }
    
    func pop() {
        root?.navigationController?.popViewController(animated: true)
    }
}
