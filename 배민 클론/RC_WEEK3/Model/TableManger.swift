//
//  TableManger.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/24.
//

import UIKit
import MobileCoreServices

class TableManger: NSObject {
    static var viewModel: TableViewModel?
    
    static var tableData = [ Restaurant(name: "한상치킨 본점", category: .chicken, reviewNum: 100, delieveryTip: 500, minDeliveryTime: 42, evaluation: 4.8, minimumOrder: 9000),
                             Restaurant(name: "혼밥대왕 부천점", category: .korean, reviewNum: 1230, delieveryTip: 1500, minDeliveryTime: 47, evaluation: 2.6, minimumOrder: 3500),
                             Restaurant(name: "24시 소나무식당", category: .korean, reviewNum: 60, delieveryTip: 2500, minDeliveryTime: 39, evaluation: 4.9, minimumOrder: 10000),
                             Restaurant(name: "프리미엄 쫄면 삼겹 고돼지 부천점", category: .korean, reviewNum: 250, delieveryTip: 2500, minDeliveryTime: 49, evaluation: 4.6, minimumOrder: 9000),
                             Restaurant(name: "밥도둑 한끼뚝딱 부천심곡점", category: .korean, reviewNum: 24, delieveryTip: 2500, minDeliveryTime: 48, evaluation: 4.7, minimumOrder: 6900),
                             Restaurant(name: "윤정무의 유쾌한 쫄면", category: .school, reviewNum: 1, delieveryTip: 4000, minDeliveryTime: 50, evaluation: 1.4, minimumOrder: 15000),
    ]
    static var menuData: [Menu] = [ Menu(name: "덮밥", detail: "혼자먹기 딱좋은 치밥", price: 16000),
                                    Menu(name: "두마리 두마리 chicken", detail: "선택후 메뉴 선택", price: 22000),
                                    Menu(name: "Best 매콤 찐 마늘간장", detail: "한상chicken best", price: 17000),
                                    Menu(name: "후라이드", detail: "말해뭐해 자신있습니다", price: 16000),
                                    Menu(name: "청양마추", detail: "청양고추,마요네즈,고추기름으로 만든 치킨", price: 18000),
                                    Menu(name: "파닭", detail: "사장이 제일좋아하는 메뉴", price: 18000)
    ]
    
    
    static func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        
        let place = TableManger.menuData[sourceIndex]
        TableManger.menuData.remove(at: sourceIndex)
        TableManger.menuData.insert(place, at: destinationIndex)
    }
    
    /// The method for adding a new item to the table view's data model.
    static func addItem(_ menu: Menu, at index: Int) {
        TableManger.menuData.insert(contentsOf: [menu], at: index)
    }
}


