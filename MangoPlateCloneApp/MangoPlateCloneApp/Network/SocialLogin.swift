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
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        if !isValidAccessToken {
                return
              }
              
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        
        let requestUrl = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: requestUrl)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON { response in
            
            guard let body = response.value as? [String: Any] else { return }
            
            if let resultCode = body["message"] as? String{
                if resultCode.trimmingCharacters(in: .whitespaces) == "success"{
                    let resultJson = body["response"] as! [String: Any]
                    
                    let name = resultJson["name"] as? String ?? ""
                    let id = resultJson["id"] as? String ?? ""
                    let phone = resultJson["mobile"] as! String
                    let gender = resultJson["gender"] as? String ?? ""
                    let birthyear = resultJson["birthyear"] as? String ?? ""
                    let birthday = resultJson["birthday"] as? String ?? ""
                    let profile = resultJson["profile_image"] as? String ?? ""
                    let email = resultJson["email"] as? String ?? ""
                    let nickName = resultJson["nickname"] as? String ?? ""
                    
                    print("네이버 로그인 이름 ",name)
                    print("네이버 로그인 아이디 ",id)
                    print("네이버 로그인 핸드폰 ",phone)
                    print("네이버 로그인 성별 ",gender)
                    print("네이버 로그인 생년 ",birthyear)
                    print("네이버 로그인 생일 ",birthday)
                    print("네이버 로그인 프로필사진 ",profile)
                    print("네이버 로그인 이메일 ",email)
                    print("네이버 로그인 닉네임 ",nickName)
                }
                else{
                  
                }
            }
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
