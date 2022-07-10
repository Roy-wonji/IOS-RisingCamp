//
//  TinderColors.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/07.
//

import Foundation
import UIKit

extension UIColor{
    
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
        class var mainOrange: UIColor { UIColor(hex: 0xF5663F) }
        
        class var barTintColor: UIColor? {
        return UIColor(named: "main")
    }
    
        class var unselectedGray: UIColor {
        return UIColor(red:0.85, green:0.87, blue:0.90, alpha:1.0)
    }
}
