//
//  ViewController.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/20.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var eventScrollView: UIScrollView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var deliveryButton: UIButton!
    @IBAction func buttonTapped(_ sender: UIButton) {
        
    }
    
    private  let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    private func configureUI() {
        Observable.just(MainViewController())
            .subscribe(
                onNext: { _ in
                    self.view.backgroundColor =  UIColor(displayP3Red: 95/255, green: 190/255, blue: 187/255, alpha: 1)
                    self.configureNavigationBar()
                    self.configureSearchView()
                    self.configureSearchBar()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func configureNavigationBar() {
        Observable<UINavigationItem>.just(navigationBar)
            .subscribe(
                onNext: {_ in
                    self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
                    self.navigationController?.navigationBar.tintColor = .white
                })
            .disposed(by: disposeBag)
    }
    
    
    private func configureSearchView() {
        Observable<UIView>.just(searchView)
            .subscribe(
                onNext: { _ in
                    self.searchView.layer.masksToBounds = true
                    self.searchView.layer.cornerRadius = 15
                    self.searchView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
                })
            .disposed(by: disposeBag)
    }
    
    
    private func configureSearchBar() {
        Observable<UISearchBar>.just(searchBar)
            .subscribe(
                onNext: { _ in
                    self.searchBar.placeholder = "찾아라 맛있는 음식과 맛집"
                })
            .disposed(by: disposeBag)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor(named: "main")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "main")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        navigationController?.navigationBar.barTintColor = nil
        navigationController?.navigationBar.backgroundColor = nil
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        
    }
    

}

