//
//  LoginViewController.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/04.
//

import RxSwift
import RxAlamofire
import NaverThirdPartyLogin
import RxKakaoSDKAuth
import RxCocoa
import RxKakaoSDKUser
import KakaoSDKUser
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    //MARK: - loginView 호출
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    private let disposeBag = DisposeBag()
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    //MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    private func configureUI() {
        Observable<UIViewController>.just(LoginViewController())
            .subscribe(
                onNext: { _ in
                    self.addTarget()
                })
            .disposed(by: disposeBag)
    }
    //naverLoginButtonHandle
    private func addTarget() {
        loginView.naverLoginButton.rx.tap.subscribe(onNext: { [weak self] in self?.naverLoginButtonHandle()
        }).disposed(by: disposeBag)
        
        loginView.kakoLoginButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.kakoLoginButtonHandle()
        }).disposed(by: disposeBag)
        
        loginView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonHandle), for: .touchUpInside)
    }
    
    
    //MARK: - Actions
    
    //MARK: - 네이버 로그인
    @objc func naverLoginButtonHandle() {
        loginInstance?.delegate = self
        Single.just(loginInstance)
            .subscribe(
                onSuccess: { _ in
                    self.loginInstance?.requestThirdPartyLogin()
                },
                onFailure: { error in
                    print(error.localizedDescription)
                })
            .disposed(by: disposeBag)
        
    }
    
    //MARK: - 카카오 로그인
    @objc func kakoLoginButtonHandle() {
        UserApi.shared.rx.loginWithKakaoAccount()
            .subscribe(onNext:{ (oauthToken) in
                print("loginWithKakaoAccount() success.")
                //do something
                _ = oauthToken
                let controller = MainViewController()
                controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true)
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag )
    }
    
    
    //MARK:  애플 로그인
    @objc func appleLoginButtonHandle() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = MainViewController()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
}

//MARK:  - 네이버 로그인 확장
extension LoginViewController: NaverThirdPartyLoginConnectionDelegate  {
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success Login, ")
        SocialLogin.getNaverInfo()
        let controller = MainViewController()
        present(controller, animated: true)
        
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
//      let controller = LoginViewController()
//        present(controller, animated: true)
        
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        loginInstance?.requestDeleteToken()
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Error] :,\(error.localizedDescription)")
    }
}

extension LoginViewController:  ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let idToken = appleIDCredential.identityToken!
            let tokeStr = String(data: idToken, encoding: .utf8)
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            print("token : \(String(describing: tokeStr))")
            let controller = MainViewController()
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true)
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(SocialError.appleLoginError.appleLoginError.localizedDescription)
    
    }
    
}
