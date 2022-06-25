//
//  FrameViewController.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import Tabman
import Pageboy


final class FrameViewController: TabmanViewController {
    //MARK: - Properties
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var homebutton: UITabBarItem!
    @IBOutlet weak var nextToTableView: UIButton!
    private let disposeBag = DisposeBag()
    
    
    private var viewController = [UIViewController(), UIViewController(), UIViewController(), UIViewController(), UIViewController(), UIViewController(), UIViewController()]
    
    private let tabBar = TMBar.ButtonBar()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
      
        
    }
    
    private func configureUI() {
        Observable.just(FrameViewController())
            .subscribe(
                onNext: { _ in
                    self.view.backgroundColor = .white
                    self.configureNavigationBar()
                    self.tabmanBar()
                    self.configureRightNavigationBar()
                })
            .disposed(by: disposeBag)
    }
    
    
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func configureRightNavigationBar() {
        guard let leftitem = navigationController?.navigationItem.rightBarButtonItem else { return  }
        Observable<UIBarButtonItem>.just(leftitem)
            .subscribe(
                onNext: { _ in
                       
                })
            .disposed(by: disposeBag)
    
    }
    
    
    private func tabmanBar() {
        Observable<UIView>.just(tabBar)
            .subscribe(
                onNext: { _ in
                    self.dataSource = self
                    self.settingTabBar(ctBar: self.tabBar)
                    self.addBar(self.tabBar, dataSource: self, at: .top)
                })
            .disposed(by: disposeBag)
    }
    //MARK: - Actions

    
    @IBAction func buttonTapped(_ sender: UIButton) {
        Observable<UIButton>.just(nextToTableView)
            .subscribe(
                onNext: { _ in
                    let controller = TableViewController()
                    self.present(controller, animated: true)
                    
                })
            .disposed(by: disposeBag)
    }
    
}

extension FrameViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
   
        // MARK: -Tab 안 글씨들
        switch index {
        case 0:
            return TMBarItem(title: "배민1")
        case 1:
            return TMBarItem(title: "배달")
        case 2:
            return TMBarItem(title: "포장")
        case 3:
            return TMBarItem(title: "B마트")
        case 4:
            return TMBarItem(title: "배민스토어")
        case 5:
            return TMBarItem(title: "쇼핑라이브")
        case 6:
            return TMBarItem(title: "선물하기")
        case 7:
            return TMBarItem(title: "전국별미")
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


extension FrameViewController {
    func settingTabBar (ctBar : TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .progressive
            // 왼쪽 여백주기
            ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 13.0, bottom: 0.0, right: 20.0)
            // 간격
            ctBar.layout.interButtonSpacing = 35
            ctBar.backgroundView.style = .blur(style: .light)
            
            // 선택 / 안선택 색 + font size
            ctBar.buttons.customize { (button) in
                button.layer.cornerRadius = 20
                button.tintColor = .lightGray
                button.selectedTintColor = .darkGray
                button.font = UIFont.systemFont(ofSize: 16)
                button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
            }
            
            // 인디케이터 (영상에서 주황색 아래 바 부분)
            ctBar.indicator.weight = .custom(value: 2)
            ctBar.indicator.tintColor = .black
        }
}
