//
//  MangoBarIndicator.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/07.
//

import UIKit
import Tabman
import SnapKit

 class MangoBarIndicator: TMLineBarIndicator {
    private var indicatorView = UIView()
     
    open override var displayMode: TMBarIndicator.DisplayMode {
        return .top
    }

    override func layout(in view: UIView) {
        super.layout(in: view)
        
        view.addSubview(indicatorView)
        
        indicatorView.backgroundColor = .orange
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            indicatorView.topAnchor.constraint(equalTo: view.topAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
}


