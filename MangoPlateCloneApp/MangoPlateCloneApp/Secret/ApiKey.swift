//
//  ApiKey.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/09.
//

import Foundation
import RxAlamofire
import Alamofire

struct Key {
    static let kakaoHeaders: HTTPHeaders = [
        "Authorization": "KakaoAK 3d3acc50224eabbc64f966d59cb5f1d3"
    ]
    
    static let naverHeaders: HTTPHeaders = [
        "X-Naver-Client-Id" : "0nEIPoNUvv0tsdrecP7F",
        "X-Naver-Client-Secret" : "lHucfVGhk8"
    ]
}
