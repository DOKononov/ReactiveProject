//
//  MainVC.swift
//  ReactiveProject
//
//  Created by Dmitry Kononov on 4.12.24.
//

import UIKit
import DIYReactive
import SnapKit

protocol MainViewModelInProtocol {
    var tapOnGenerate: RxPublisher<Void> { get }
    
}

protocol MainViewModelOutProtocol {
    var didReciveFact: RxPublisher<String> { get }
}

protocol MainViewModelProtocol: MainViewModelInProtocol & MainViewModelOutProtocol {}


final class MainVC: UIViewController {
    private var bag: [RxReleasable] = []
    private let viewModel: MainViewModelProtocol
    
    private lazy var gemerateButton: RxButton = {
        let button = RxButton()
        button.setTitle("Generate fact", for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var factLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
    }
    
    private func bind() {
        gemerateButton
            .onTouchUpInside
            .subscribeOn(viewModel.tapOnGenerate)
            .store(in: &bag)

        
        viewModel.didReciveFact.subscribe { [weak self] fact in
            self?.factLabel.text = fact
        }.store(in: &bag)
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(factLabel)
        view.addSubview(gemerateButton)
        
        factLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        gemerateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
}
