//
//  CoffeeData.swift
//  StarBucks_CLone
//
//  Created by 서원지 on 2022/06/15.
//

import UIKit

struct CoffeeData {
    let name: String
    let engName: String
    let price: Int
    
    func fetchImage() -> UIImage? {
        return UIImage(named: self.engName)
    }
    
    init(name: String, engName: String, price: Int) {
        self.name = name
        self.engName = engName
        self.price = price
        
       
    }
}
