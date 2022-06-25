//
//  OneViewController.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import Tabman
import Pageboy


final class TableViewController: TabmanViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var topView: UIView!
    
    private var viewControllers : Array<UIViewController> = []
    private var viewModel = TableViewModel()
    
    private let tabBar = TMBar.ButtonBar()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        Observable.just(TableViewController())
            .subscribe(
                onNext: { _ in
                    self.setTabMainView()
                    self.configureTabmanBar()
                })
            .disposed(by: disposeBag)
    }
    
    
    
    private func setTabMainView() {
        Single.just(UIViewController.self)
            .subscribe(
                onSuccess: { [self] _ in
                    let frist = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableView")  as! TableView
                    let second = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableView") as! TableView
                    let third = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableView") as! TableView
                    let fourth = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableView") as! TableView
                    let fifth = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableView") as! TableView
                    let sixth = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableView") as! TableView
                    
                    self.viewControllers.append(frist)
                    self.viewControllers.append(second)
                    self.viewControllers.append(third)
                    self.viewControllers.append(fourth)
                    self.viewControllers.append(fifth)
                    self.viewControllers.append(sixth)
                },
                onFailure: { error in
                    print(error.localizedDescription)
                })
            .disposed(by: disposeBag)
    }
    
    private func configureTabmanBar() {
        Observable<UIView>.just(tabBar)
            .subscribe(
                onNext: { _ in
                    self.dataSource = self
                    self.settingTabBar(ctBar: self.tabBar)
                    self.addBar(self.tabBar, dataSource: self, at: .top)
                })
            .disposed(by: disposeBag)
    }
}

//MARK:- tabman 확장 관련 코드
extension TableViewController : PageboyViewControllerDataSource, TMBarDataSource{
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "전체")
        case 1:
            return TMBarItem(title: "돈까스.회.일식")
        case 2:
            return TMBarItem(title: "중식")
        case 3:
            return TMBarItem(title: "치킨")
        case 4:
            return TMBarItem(title: "백반.죽.국수")
        case 5:
            return TMBarItem(title: "카페.디저트")
            
        default:
            let title = "Page\(index)"
            return TMBarItem(title: title)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return  nil
    }
}

extension TableViewController {
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
            button.selectedTintColor = UIColor.systemMint
            button.font = UIFont.systemFont(ofSize: 16)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        
        // 인디케이터 (영상에서 주황색 아래 바 부분)
        ctBar.indicator.weight = .custom(value: 2)
        ctBar.indicator.tintColor = UIColor.systemMint
    }
}
