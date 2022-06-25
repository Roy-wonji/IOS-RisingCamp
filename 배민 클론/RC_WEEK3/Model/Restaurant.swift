//
//  Menu.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/24.
//

import UIKit

struct Restaurant {
    var name: String
    var category: Category
    
    var menus: [Menu]?
    
    var reviewNum: Int
    var delieveryTip: Int
    var minDeliveryTime: Int
    
    var evaluation: Float
    var minimumOrder: Int
    
    
    func fetchIcon() -> UIImage? {
        return UIImage(named: name)
        
    }
    
    func orderDetail() -> String {
        return "최소주문 \(Decimal(minimumOrder))원, 배달팁 \(Decimal(delieveryTip))원~\(Decimal(delieveryTip + 2000))원"
    }

    func fetchImage() -> UIImage? {
        return UIImage(named: "Main-\(name)")
    }
    
    func deliveryTimeAttributedString() -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: " ")
        
        
        //삽입할 이미지
        let imageAttachment = NSTextAttachment()
        let image = UIImage(systemName: "clock")
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 14, height: 14)
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        
        attributedString.append(NSAttributedString(string: " \(self.minDeliveryTime)~\(self.minDeliveryTime + 15)분 "))
        
        return attributedString
    }
    

    func reviewAttributedString() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "")
        
        //삽입할 이미지
        let imageAttachment = NSTextAttachment()
        //삽입할 이미지 커스텀
        
        let color = UIColor(named: "star")!
        imageAttachment.image = UIImage(systemName: "star.fill")?.withTintColor(color, renderingMode: .alwaysOriginal)
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 14, height: 14)
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        
        if reviewNum > 100 {
            //            return " \(evaluation)(100+)"
            attributedString.append(NSAttributedString(string: "\(evaluation)(100+)"))
        } else {
            //            return " \(evaluation)(\(reviewNum))"
            attributedString.append(NSAttributedString(string: "\(evaluation)(\(reviewNum))"))
        }
        
        return attributedString
    }
}

