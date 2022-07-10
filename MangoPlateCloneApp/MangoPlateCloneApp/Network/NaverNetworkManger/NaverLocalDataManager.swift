//
// NaverLocalDataManager.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/10.
//

import Foundation
import Alamofire


//class NaverLocalDataManager {
//    
//    func fetchRestaurant(place_name: String, display: Int, sort: String, start: String, delegate: FindFoodVIewController)  {
//        let parameters: [String: [String]] = [
//            "display": ["\(display)"],
//            "sort": ["\(sort)"],
//            "start": ["\(start)"],
//            "query" : ["\(place_name)"]
//        ]
//        
//        print("\(start)")
//        AF.request(Constant.NAVER_SEARCH_URL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: Key.naverHeaders).va
//        .responseDecodable (of: NaverLocalDataManager.self) { response in
//                switch response.result {
//                case .success(let response):
//                    print("네트워크 성공 ")
//                    delegate.didCompleNetwork(response: response)
//                case .failure(let error):
//                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
//                    
//                }
//            }
//    }
//}
//
