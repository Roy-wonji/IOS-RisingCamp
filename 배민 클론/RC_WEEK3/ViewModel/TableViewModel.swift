//
//  TableViewModel.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/25.
//

import UIKit

class TableViewModel {
    var datas = TableManger.tableData
    
    func Decimal(_ value: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))!
        return result
    }
}

