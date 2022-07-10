//
//  UIViewController.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/10.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: 인디케이터 표시
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: 인디케이터 숨김
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
}
