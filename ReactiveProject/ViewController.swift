//
//  ViewController.swift
//  ReactiveProject
//
//  Created by Dmitry Kononov on 21.11.24.
//

import UIKit
import DIYReactive
import SnapKit

class ViewController: UIViewController {
    
    private lazy var rxButton: RxButton = {
        let button = RxButton()
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    private let service = IntSpawner.shared
    private var bag: [RxReleasable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
    }
    
    private func bind() {
        service.intDidSpawn
            .filter { $0 > .zero }
            .subscribe { print($0) }
            .store(in: &bag)
        rxButton.onTouchUpInside
            .subscribe { print($0)}
            .store(in: &bag)
    }
    
    private func setupUI() {
        view.addSubview(rxButton)
        
        rxButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }
    
}

