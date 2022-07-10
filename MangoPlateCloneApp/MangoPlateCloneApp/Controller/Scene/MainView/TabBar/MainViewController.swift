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
    private let tabBarItems = MainViewController.Tab.allCases.map({BarItem(for: $0)})
    private let systemBar = MangoBar.makeBar().systemBar()
    private var viewController = [FindFoodVIewController(), MusicViewController(), UIViewController(), UIViewController(), UIViewController()]
    
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    
        
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
                    self.systemBar.backgroundStyle = .flat(color: .white)
                    self.addBar(self.systemBar, dataSource: self, at: .bottom)
                })
            .disposed(by: disposeBag)
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
    
    private class BarItem: TMBarItemable {
        var selectedImage: UIImage?
        
        let tab: MainViewController.Tab
        
        init(for tab: MainViewController.Tab) {
            self.tab = tab
        }
        
        private var _title: String? {
            return tab.rawValue.capitalized
        }
        
        var title: String? {
            get {
                return _title
            } set {}
        }
        
        private var _image: UIImage? {
            return UIImage(named: "ic_\(tab.rawValue)")
        }
        
        var image: UIImage? {
            get {
                return _image
            } set {}
        }
        
        var badgeValue: String?
    }
}

extension MainViewController {
    enum Tab: String, CaseIterable {
        case find
        case pick
        case news
        case myProfile
    }
}

