//
//  SocialLogin.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/05.
//

import Foundation
import RxAlamofire
import Alamofire
import RxKakaoSDKUser
import KakaoSDKUser
import RxKakaoSDKAuth
import RxSwift

struct SocialLogin{
   
    static let disposeBag = DisposeBag()
    
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
