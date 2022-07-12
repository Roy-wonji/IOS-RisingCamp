//
//  FindFoodView.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/07.
//

import UIKit
import Then
import SnapKit
import ImageSlideshow


final class FindFoodView : UIView {
    //MARK: - Properties
    private var images =  ["banner1", "banner2","banner"]
  
    
    lazy var locationLabel = UILabel().then { label in
        label.text = "지금 보고 있는 지역은 "
        label.font  = UIFont.systemFont(ofSize: 10)
        label.tintColor = .black
    }
    
    
    lazy var locationButton = UIButton(type: .system).then { button in
        button.setTitle("강남", for: .normal)
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
        button.setImage(UIImage(systemName: "map"), for: .normal)
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
    
    lazy var imageview = UIImageView().then { image in
        image.contentMode = .scaleToFill
        image.image = UIImage(named:  images[0])
        image.backgroundColor = .lightGray
    }
    
    lazy var page = UIPageControl().then { page in
        page.numberOfPages = images.count
        page.pageIndicatorTintColor = .black
        page.currentPageIndicatorTintColor = .lightGray
        page.currentPage = .zero
        page.addTarget(self, action: #selector(changePage), for: .allEvents)
    }
    
    private lazy var topStack = UIStackView(arrangedSubviews: [imageview, page]).then { stack in
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.alignment = .fill
    }
    
    lazy var flatButton = UIButton(type: .custom).then { button in
        button.setTitle("평점순", for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .lightGray
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var distanceButton =  UIButton(type: .custom).then { button in
        button.setTitle("5km", for: .normal)
        button.setImage(UIImage(systemName: "location.viewfinder"), for: .normal)
        button.tintColor = .systemOrange
        button.setTitleColor(.systemOrange, for: .normal)
    }
    
    
    lazy var filterButton = UIButton(type: .custom).then { button in
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.setTitle("평점", for: .normal)
        button.tintColor = .lightGray
        button.setTitleColor(.lightGray, for: .normal)
    }
    
    private lazy var bottomButtonStack = UIStackView(arrangedSubviews: [distanceButton, filterButton]).then { stack in
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .equalCentering
        stack.spacing  = 10
    }
    
    private lazy var bottomButtonMainStack = UIStackView(arrangedSubviews: [flatButton,bottomButtonStack]).then { stack in
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 20
    }

    private lazy var bottomImageView = UIImageView().then { image in
        image.contentMode = .scaleAspectFill
        image.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        image.image = UIImage(named: "banner")
    }
    
    lazy var mainBottomStack = UIStackView(arrangedSubviews: [bottomButtonMainStack, bottomImageView]).then { stack in
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 15
        stack.distribution = .equalSpacing
    }
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 20 ,  height: 300)
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        return collectionView
    }()
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        updateViews()
        updateConstraints()
        
    }
    
    private  func updateViews() {
        self.addSubview(stackView)
        self.addSubview(topStack)
        self.addSubview(mainBottomStack)
        self.addSubview(collection)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changePage() {
        imageview.image = UIImage(named: images[page.currentPage])
    }
    
    //MARK: - UI
    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        setConstraintsLocationLabel()
        setConstraintsTopStackView()
        setConstraintsBottomStackView()
        setConstraintsColletionView()
    }
    
    
    
    private func setConstraintsLocationLabel() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
    }
    
    
    private func setConstraintsTopStackView() {
        topStack.snp.makeConstraints { make in
            make.top.equalTo(topButtonStack.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    
    private func  setConstraintsBottomStackView() {
        mainBottomStack.snp.makeConstraints { make in
            make.top.equalTo(topStack.snp.bottom).offset(10)
            make.leading.equalTo(topStack.snp.leading).offset(2)
            make.trailing.equalToSuperview()
        }
    }
    
    private func setConstraintsColletionView() {
        collection.snp.makeConstraints { make in
            make.top.equalTo(mainBottomStack.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

