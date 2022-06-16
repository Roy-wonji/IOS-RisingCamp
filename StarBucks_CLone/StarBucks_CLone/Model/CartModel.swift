//
//  CartModel.swift
//  StarBucks_CLone
//
//  Created by 서원지 on 2022/06/16.
//

import UIKit

 class CartModel {
    static func orderPushNotification() {
        let content = UNMutableNotificationContent()
        content.title = "주문완료"
        content.subtitle = "로이님"
        content.body = "주문이 접수되었어요!☕️ 음료가 준비되면 닉네임을 불러드려요!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats:  false)
        let requset = UNNotificationRequest(identifier: Cellidentifier.cartIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(requset) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
