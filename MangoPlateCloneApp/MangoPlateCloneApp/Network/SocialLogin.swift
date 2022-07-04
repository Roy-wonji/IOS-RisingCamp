//
//  SocialLogin.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/05.
//

import Foundation
import RxAlamofire
import Alamofire
import NaverThirdPartyLogin
import RxKakaoSDKUser
import KakaoSDKUser
import RxKakaoSDKAuth
import RxSwift

struct SocialLogin{
    static  let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
     static let disposeBag = DisposeBag()
    static func getNaverInfo() {
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.tokenType else { return }
        
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        guard let url = URL(string: urlStr) else {return}
        
        let authorization = "\(tokenType) \(accessToken)"
        debugPrint(tokenType)
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        request.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            guard let id = object["id"] as? String else {return}
            
            print("response: ",response)
            
        }
    }
    
    
    static func kakoLogin() {
        UserApi.shared.rx.loginWithKakaoAccount()
            .subscribe(onNext:{ (oauthToken) in
                print("loginWithKakaoAccount() success.")

                //do something
                _ = oauthToken
                
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag )
    }
}
