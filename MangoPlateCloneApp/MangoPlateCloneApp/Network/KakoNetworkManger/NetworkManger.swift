//
//  NetworkManger.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/10.
//

import Foundation
import RxSwift

struct NetworkManger{
    static var findView = FindFoodView()
    static var disposeBag = DisposeBag()
    static  var isAvailable = true
    static func  requsetNetwork(response: KakaoLocalResponse) {
        
            Single.just(FindFoodVIewController())
                .subscribe(
                    onSuccess: { _ in
                        DispatchQueue.main.async {
                            self.findView.collection.refreshControl?.endRefreshing()
                        }
                        if response.meta.is_end {
                            self.isAvailable = true
                        } else {
                            self.isAvailable = false
                        }
                        print(response.documents)
                        
                    },
                    onFailure: { error in
                        print(error.localizedDescription)
                    
                    }
                )
                .disposed(by: disposeBag)
        }
        
        
        
        
        
        
       
    }

