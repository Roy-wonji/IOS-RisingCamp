//
//  MainTabViewController.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/21.
//

import UIKit
import RxSwift
import RxCocoa


final class MainTabViewController: UITabBarController {
    
    @IBOutlet weak var homaButton: UIBarButtonItem!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func homeTabButton(_ sender: UIBarButtonItem) {
        Observable<UIBarButtonItem>.just(homaButton)
            .subscribe(
                onNext: {  _ in
                    _ = self.navigationController?.popViewController(animated: true)
                    
                })
            .disposed(by: disposeBag)
    }
}
