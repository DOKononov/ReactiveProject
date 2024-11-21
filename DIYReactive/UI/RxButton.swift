//
//  RxButton.swift
//  DIYReactive
//
//  Created by Dmitry Kononov on 21.11.24.
//

import UIKit

public final class RxButton: UIButton {
    
    public var onTouchUpInside: RxPublisher<Void> = .init()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupRx()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    private func setupRx() {
        addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
    }
    
   @objc private func didTouchUpInside() {
       onTouchUpInside.send(event: ())
    }
}
