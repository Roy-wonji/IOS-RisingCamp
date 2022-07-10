//
//  FoodVIewModel.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/10.
//

import Foundation

struct FoodVIewModel {
    var restinfo: Restaurant?
    
    var title: String? {
        return restinfo?.place_name
    }
    
}
