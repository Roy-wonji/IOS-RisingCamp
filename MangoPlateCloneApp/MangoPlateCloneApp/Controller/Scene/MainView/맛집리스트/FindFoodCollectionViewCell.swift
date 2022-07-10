//
//  FindFoodCollectionViewCell.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/09.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class FindFoodCollectionViewCell: UICollectionViewCell {
    
    //MARK:  - Properties
    private let disposeBag = DisposeBag()
    private var restInfo: RestInfo? = nil
    
    lazy var foodImage = UIImageView().then { image in
        image.image = UIImage(named: "fake")
        image.contentMode = .scaleToFill
    }
    
    lazy var titlelabels = UILabel().then { label in
        label.text = "맛집"
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
    }
    
    lazy var elevationButton = UIButton(type: .system).then { button in
        button.setTitleColor(.barTintColor, for: .normal)
        button.setTitle("4.4", for: .normal)
        button.setTitleColor(.barTintColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .left
    }
    
    lazy var toplabelStack = UIStackView(arrangedSubviews: [titlelabels]).then { stack in
        stack.axis = .horizontal
        stack.alignment = .trailing
        stack.alignment = .leading
        stack.spacing = 10
        stack.distribution = .fill
    }
    
    lazy var distanceLabel = UILabel().then { label in
        label.text = "삼성동 261m"
        label.font = UIFont.systemFont(ofSize: 10)
        label.tintColor = .lightGray
    }
    
    lazy var viewCountLabel = UILabel().then { label in
        label.text = "116.300"
        label.font = UIFont.systemFont(ofSize: 10)
        label.tintColor = .lightGray
    }
    
    lazy var reviewCountLabel =  UILabel().then { label in
        label.text = "117"
        label.font = UIFont.systemFont(ofSize: 10)
        label.tintColor = .lightGray
    }
    
    private lazy var reviewStack = UIStackView(arrangedSubviews: [viewCountLabel, reviewCountLabel]).then { stack in
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
    }
    
    private lazy var bottomLabelStack = UIStackView(arrangedSubviews: [ distanceLabel , reviewStack]).then { stack in
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 5
        stack.distribution = .equalSpacing
    }
    
    var imageUrl: String? {
    
        didSet {
            loadImage()
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadImage() {
        guard let urlString =  self.imageUrl , let url = URL(string: urlString) else {return}
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard urlString == url.absoluteString else { return }
            DispatchQueue.main.async {
                self.foodImage.image = UIImage(data: data)
                
            }
        }
    }
    //MARK:  - ui
    
    private func configureUI() {
        Observable.just(UICollectionViewCell())
            .subscribe(
                onNext: { _ in
                    self.updateView()
                    self.updateConstraints()
                })
            .disposed(by: disposeBag)
        
    }
    
    private func updateView() {
        self.addSubview(foodImage)
        self.addSubview(toplabelStack)
        self.addSubview(elevationButton)
        self.addSubview(bottomLabelStack)
    }
    
    
    //MARK: - 레이아웃 코드
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        setConstraintsImage()
        setConstraintsTopLabelStack()
        setConstraintsElevationButton()
        setConstraintsBottomLabelStack()
    }
    
    
    private func setConstraintsImage() {
        foodImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(202)
            make.width.equalTo(202)
        }
    }
    
    private func setConstraintsTopLabelStack() {
        toplabelStack.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom).offset(5)
            make.leading.equalTo(foodImage.snp.leading)
            make.trailing.equalTo(foodImage.snp.trailing)
        }
    }
    
    private func setConstraintsElevationButton() {
        elevationButton.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom).offset(8)
            make.trailing.equalTo(toplabelStack.snp.trailing).offset(-10)
        }
    }
    
    private func setConstraintsBottomLabelStack(){
        bottomLabelStack.snp.makeConstraints { make in
            make.top.equalTo(toplabelStack.snp.bottom)
            make.leading.equalTo(foodImage.snp.leading)
            
        }
    }
}
