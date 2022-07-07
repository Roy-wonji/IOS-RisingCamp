//
//  FindFoodVIewController.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/07.
//

import UIKit
import SnapKit
import Then
import RxSwift


final class FindFoodVIewController: UIViewController {
    
    //MARK: - Properties
    
    private let dispoeBag = DisposeBag()
    private lazy var carouselView: UICollectionView = {
           let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width:view.frame.width, height: 128)
        flowlayout.estimatedItemSize = .zero
           flowlayout.minimumLineSpacing = 0
        flowlayout.estimatedItemSize = .zero
        
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.scrollDirection = .horizontal
        
           
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.isPrefetchingEnabled = true
           collectionView.isPagingEnabled = true
       
           collectionView.showsHorizontalScrollIndicator = true
           return collectionView
       }()
       
    var nowPage: Int = 0
    let dataArray: Array<UIImage?> = [UIImage(named: "banner1"), UIImage(named: "banner"), UIImage(named: "banner1")]
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        carouselView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.height.equalTo(200)
        }
//        NSLayoutConstraint.activate([
//                   carouselView.topAnchor.constraint(equalTo: view.topAnchor),
//                   carouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                   carouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                   carouselView.heightAnchor.constraint(equalToConstant: 300),
//               ])
    }
    
    //MARK:  - UI
    private func configureUI() {
        Observable.just(FindFoodVIewController())
            .subscribe(
                onNext: { [self] _ in
                        self.configureCollectionView()
                    self.view.addSubview(self.carouselView)
                      
                })
            .disposed(by: dispoeBag)
    }

    
    private  func configureCollectionView() {
        carouselView.register(BannerCell.self,
                              forCellWithReuseIdentifier: CellIdentifier.bannerCollectionViewIdentifier)
               carouselView.dataSource = self
               carouselView.delegate = self
       
        
        //        NSLayoutConstraint.activate([
//                   carouselView.topAnchor.constraint(equalTo: view.topAnchor),
//                   carouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                   carouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                   carouselView.heightAnchor.constraint(equalToConstant: 300),
//
//                   carouselProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                   carouselProgressView.bottomAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: -20),
//                   carouselProgressView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
//               ])
        
    }
}


extension FindFoodVIewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.bannerCollectionViewIdentifier, for: indexPath) as! BannerCell
        cell.imageview.image = dataArray[indexPath.row]
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
}

extension FindFoodVIewController: UICollectionViewDelegate {
    
}
