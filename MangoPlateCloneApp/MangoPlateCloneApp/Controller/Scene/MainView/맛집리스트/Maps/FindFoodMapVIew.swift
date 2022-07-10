//
//  FindFoodMapVIew.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/11.
//

import UIKit
import RxSwift
import SnapKit
import  Then
import MapKit

final class FindFoodMapVIew: UIView {
    
    //MARK: - Propeties
    lazy var locationLabel = UILabel().then { label in
        label.text = "지금 보고 있는 지역은 "
        label.font  = UIFont.systemFont(ofSize: 10)
        label.tintColor = .black
    }
    
    
    lazy var locationButton = UIButton(type: .system).then { button in
        button.setTitle("강남구", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
    
    private lazy var topButtonStack = UIStackView(arrangedSubviews: [locationLabel, locationButton]).then { stack in
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        stack.alignment = .leading
    }
    
    lazy var searchBarButton = UIButton(type: .custom).then { button in
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .lightGray
    }
    
    lazy var mapBarButton =  UIButton(type: .custom).then { button in
        button.setImage(UIImage(systemName: "map.fill"), for: .normal)
        button.tintColor = .lightGray
    }
    
    private lazy var buttonStack = UIStackView(arrangedSubviews: [searchBarButton, mapBarButton]).then { stack in
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fill
        stack.alignment = .fill
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [topButtonStack, buttonStack]).then { stack in
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .equalSpacing
        stack.alignment = .fill
    }
    
    lazy var mapView = MKMapView().then { map in
//        map.
    }
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        upadateView()
        updateConstraints()
    }
    
    private func upadateView() {
        self.addSubview(stackView)
    }
    
    //MARK:  - UI
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func  setConstraints() {
        setConstraintsLocationLabel()
    }
    
    
    private func setConstraintsLocationLabel() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
    }
}
