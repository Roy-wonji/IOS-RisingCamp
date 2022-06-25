//
//  TableView.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/25.
//

import UIKit
import RxSwift

final class TableView : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreashControl = UIRefreshControl()
    var viewModel = TableViewModel()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
    }
    
    
    private func configureTableView() {
        guard let tableView = tableView else {return}
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreashControl
        refreashControl.addTarget(self, action: #selector(pullToRefreash(_:)), for: .valueChanged)
    }
}


//MARK:  - UITableViewDelegate

extension TableView: UITableViewDelegate {
    
}


//MARK: - UITableViewDataSource

extension TableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableManger.tableData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CellIdentifier.tableViewCellIdentifier)") as! TableViewCell
        let index = indexPath.row
        let data = TableManger.tableData[index]
        
        cell.titleLabel.text = data.name
        cell.tagLabel.text = data.category.rawValue
        cell.orderDetailLabel.text = data.orderDetail()
        cell.reviewLabel.attributedText = data.reviewAttributedString()
        cell.deliveryIntervalLabel.attributedText = data.deliveryTimeAttributedString()
        cell.marketImageView.image = data.fetchIcon() ?? UIImage(named: "밥도둑 한끼뚝딱 부천심곡점")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row  = indexPath.row
        print("\(row) has selected")
    }
    
}


extension TableView {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Single.just(TableView())
            .subscribe(
                onSuccess: { _ in
                    if segue.identifier == "detailSegue"
                        ,let destination = segue.destination as? DetailViewController
                        ,let restaurantIndex = self.tableView.indexPathForSelectedRow?.row {
                        print("세그  성공")
                        print("\(restaurantIndex) has selected")
                        
                        destination.data = TableManger.tableData[restaurantIndex]
                    }
                }, onFailure: { error in
                    print(error.localizedDescription)
                })
            .disposed(by: disposeBag)
        
    }
}


//MARK:  - tableview를 스크롤 했을때
extension TableView {
    
    @objc func pullToRefreash(_ sender: Any) {
        
        let new = Restaurant(name: "새로 입점", category: .cafe, reviewNum: 0, delieveryTip: 2500, minDeliveryTime: 30, evaluation: 0.0, minimumOrder: 10000)
        //새로운데이터 추가
        TableManger.tableData.append(new)
        //테이블뷰 갱신
        self.tableView.reloadData()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (refreashControl.isRefreshing) {
            self.refreashControl.endRefreshing()
        }
    }
    
    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TableManger.tableData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}
