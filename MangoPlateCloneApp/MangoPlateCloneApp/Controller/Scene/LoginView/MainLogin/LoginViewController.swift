//
//  LoginViewController.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/04.
//

import RxSwift
import RxAlamofire
import RxKakaoSDKAuth
import RxCocoa
import RxKakaoSDKUser
import KakaoSDKUser
import AuthenticationServices
import Firebase
import FirebaseAuth
import GoogleSignIn


final class LoginViewController: UIViewController {
    
    //MARK: - loginView 호출
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    private let disposeBag = DisposeBag()
    
    
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
        loginView.googleLoginButton.rx.tap.subscribe(onNext: { [weak self] in self?.googleLoginButtonHandle()
        }).disposed(by: disposeBag)
        
        loginView.kakoLoginButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.kakoLoginButtonHandle()
        }).disposed(by: disposeBag)
        
        loginView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonHandle), for: .touchUpInside)
        
        loginView.loginButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.emailLoginButtonHandle()
        }).disposed(by: disposeBag)
        
        loginView.nextViewButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.jumpLoginButtonHandle()
        }).disposed(by: disposeBag)
        
    }
    
    
    //MARK: - Actions
    
    //MARK: - 구글 로그인
    @objc func googleLoginButtonHandle() {
        Single.just(FirebaseApp.self)
            .subscribe(
                onSuccess: {_ in
                    guard let clientID = FirebaseApp.app()?.options.clientID  else {return}
                    let config = GIDConfiguration(clientID: clientID)
                    GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
                        guard error == nil else { return }
                        guard let authentication = user?.authentication, let idToken = authentication.idToken else {return}
                        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                       accessToken: authentication.accessToken)
                        Auth.auth().signIn(with: credential) { _, error in
                            // 사용자 등록 후에 처리할 코드
                            let controller = MainViewController()
                            controller.modalPresentationStyle = .fullScreen
                            self.present(controller, animated: true)
                        }
                    }
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
    
    //MARK: - 이메일 로그인
    @objc func emailLoginButtonHandle() {
        let controller  = EmailLoginViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:  - 건너뛰기 버튼
    @objc func jumpLoginButtonHandle() {
        let controller  = MainViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
}

//MARK: - 애플 로그인
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
