//
//  EmailLoginViewController.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/06.
//

import UIKit
import RxSwift

final class EmailLoginViewController: UIViewController {
    //MARK:  - Properties
    
    private let emailView = EmailLoginView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = emailView
    }
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigtionBar()
        
    }
    
    //MARK:  - UI
    
    private func configureUI() {
        
    
    }
    
    private func setNavigtionBar() {
       
    }
}
