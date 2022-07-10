//
//  FindFoodMapVIewController.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/11.
//

import UIKit
import RxSwift

final class FindFoodMapVIewController: UIViewController {
    private let findMapView = FindFoodMapVIew()
    private let disposeBag = DisposeBag()
    override func loadView() {
        view = findMapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    private  func configureUI() {
        addTarget()
    }
    
    private func addTarget() {
        findMapView.mapBarButton.rx.tap.subscribe(onNext: {
            self.backToFindViewHandle()
        })
        .disposed(by: disposeBag)
    }
    
    @objc func backToFindViewHandle() {
        self.dismiss(animated: true)
    }
}
