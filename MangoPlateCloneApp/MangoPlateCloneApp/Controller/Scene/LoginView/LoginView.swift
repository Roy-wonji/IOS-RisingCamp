//
//  LoginView.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/04.
//

import UIKit
import RxSwift
import SnapKit
import Then
import AuthenticationServices


final class LoginView: UIView {
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    
    
    lazy var backgroundImageView = UIImageView().then { uiImage in
        uiImage.image = UIImage(named: "login_background")
        uiImage.layer.shadowOpacity = 0.3
        
    }
    
    lazy var loginImage = UIImageView().then { image in
        image.image = UIImage(named: "login_logo")
        image.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    lazy var loginLabel = UILabel().then { label in
        label.text = "맛 집 찾 고 싶 을 때"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.tintColor = .white
        label.textColor = .init(white: 8.0, alpha: 0.3)
        label.textAlignment = .center
    }
    
    
    lazy var topStackView = UIStackView(arrangedSubviews: [loginImage, loginLabel]).then { stack in
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.alignment = .fill
    }
    
    lazy var naverLoginButton = UIButton(type: .custom).then { button in
        button.setImage(UIImage(named: "naver_login"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 40 / 2
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    lazy var kakoLoginButton = UIButton(type: .custom).then { button in
        button.setImage(UIImage(named: "login_kakao"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius =  40 / 2
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    lazy var appleLoginButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black).then { button in
        button.clipsToBounds = true
        button.layer.cornerRadius = 40 / 2
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    lazy var orImageView = UIImageView().then { image in
        image.image = UIImage(named: "or")
        image.heightAnchor.constraint(equalToConstant: 35).isActive = true
        image.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    lazy var loginButton = UIButton(type: .system).then { button in
        button.clipsToBounds = true
        button.setTitle("이메일로 계속하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 40 / 2
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    lazy var loginButtonStack = UIStackView(arrangedSubviews: [naverLoginButton, kakoLoginButton, appleLoginButton, orImageView, loginButton]).then { stack in
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
    }
    
    lazy var nextViewButton = UIButton(type: .custom).then { button in
        button.setTitle("건너뛰기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateVIews()
        updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:  - UI
    private func configureUI() {
        Observable.just(LoginView())
            .subscribe(
                onNext: { _ in
                    self.updateVIews()
                    self.updateConstraints()
                })
            .disposed(by: disposeBag)
    }
    
    
    private func updateVIews() {
        self.addSubview(backgroundImageView)
        self.addSubview(topStackView)
        self.addSubview(loginButtonStack)
        self.addSubview(nextViewButton)
    }
    //MARK: - 오토레이아웃 코드
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        setConstraintsBackgroundImageView()
        setConstraintsTopStackView()
        setConstraintsLoginButtonStack()
        setConstraintsNextViewButton()
        
    }
    
    private func setConstraintsBackgroundImageView() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    private func setConstraintsTopStackView() {
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.trailing.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(50)
        }
    }
    
    private func setConstraintsLoginButtonStack() {
        loginButtonStack.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(30)
            make.leading.equalTo(topStackView.snp.leading).offset(30)
            make.trailing.equalTo(topStackView.snp.trailing).offset(-30)
        }
    }
    
    
    private func setConstraintsNextViewButton() {
        nextViewButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.trailing.equalTo(-20)
        }
    }
}
