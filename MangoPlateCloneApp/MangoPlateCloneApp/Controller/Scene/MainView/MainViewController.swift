//
//  MainViewController.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/05.
//

import UIKit
import Tabman
import Pageboy
import RxSwift
import SnapKit

final class MainViewController: TabmanViewController {

    //MARK: - properties
    private let tabBar = TMBar.ButtonBar()
    private var disposeBag = DisposeBag()
    private var tabView = UIView()
    private var viewController = [FindFoodVIewController(), UIViewController(), UIViewController(), UIViewController(), UIViewController()]
    
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        tabview()
        
    }
    
    
    private func configureUI() {
        Observable.just(MainViewController())
            .subscribe(
                onNext: { _ in
                        self.view.backgroundColor = .white
                    self.tabmanBar()
                })
            .disposed(by: disposeBag)
    }
    
    
    private func tabmanBar() {
        Observable<UIView>.just(tabBar)
            .subscribe(
                onNext: { _ in
                    self.dataSource = self
                    self.settingTabBar(ctBar: self.tabBar)
                    self.addBar(self.tabBar, dataSource: self, at: .custom(view: self.tabView, layout: nil))
                })
            .disposed(by: disposeBag)
    }
    
    
    private func tabview() {
        view.addSubview(tabView)
        tabView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(60)
        }
    }
}


extension MainViewController:  PageboyViewControllerDataSource, TMBarDataSource  {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "맛집 찾기", image: UIImage(systemName: "list.dash")!, selectedImage: UIImage(systemName: "list.dash"))
        case 1:
            return TMBarItem(title: "망고픽", image: UIImage(systemName: "bookmark.fill")! , selectedImage: UIImage(systemName: "bookmark.fill"))
        case 2:
            return TMBarItem(title: "+", image: UIImage(systemName: "plus.circle")!, selectedImage: UIImage(systemName: "plus.circle"))
        case 3:
            return TMBarItem(title: "소식" , image: UIImage(systemName: "message")! , selectedImage: UIImage(systemName: "message"))
        case 4:
            return TMBarItem(title: "프로필", image: UIImage(systemName: "person.circle")!, selectedImage: UIImage(systemName: "person.circle"))
            
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        //위에서 선언한 vc array의 count를 반환합니다.
        return viewController.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewController[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

extension MainViewController{
    func settingTabBar (ctBar : TMBar.ButtonBar) {
        
        ctBar.layout.transitionStyle = .snap
    
            // 왼쪽 여백주기
        ctBar.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        ctBar.layout.contentInset = UIEdgeInsets(top: .zero, left: 20.0, bottom: 20.0, right: 20.0)
            // 간격
            ctBar.layout.interButtonSpacing = 40
            ctBar.backgroundView.style = .blur(style: .light)
            // 선택 / 안선택 색 + font size
            ctBar.buttons.customize { (button) in
                button.layer.cornerRadius = 20
                button.tintColor = .lightGray
                button.selectedTintColor = .systemOrange
                button.font = UIFont.systemFont(ofSize: 16)
                button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
            }
            
            // 인디케이터 (영상에서 주황색 아래 바 부분)
            ctBar.indicator.weight = .custom(value: 2)
            ctBar.indicator.tintColor = .black
        }}
