//
//  CustomLabel.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/10.
//

import UIKit


class CustomLabel: UILabel {
    
    init(plaeceholder : String){
        super.init(frame: .zero)
        
        attributedText = NSAttributedString(string: plaeceholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        numberOfLines = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

