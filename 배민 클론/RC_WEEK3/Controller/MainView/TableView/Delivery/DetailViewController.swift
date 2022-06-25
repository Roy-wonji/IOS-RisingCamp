//
//  DeliveryViewController.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/21.
//

import UIKit
import RxSwift

final class DetailViewController : UIViewController {
    //MARK:  - Properties
    
    var data: Restaurant?
    var selectIndexPath : (IndexPath, Bool)?
    var disposeBag = DisposeBag()
    var viewModel = TableViewModel()
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewValueLabel: UILabel!
    @IBOutlet weak var heartCount: UIButton!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Hepelers
    
    
    private func configureUI() {
        Observable.just(DetailViewController())
            .subscribe(
                onNext:{ _ in
                    DispatchQueue.main.async {
                        self.configureTableView()
                        self.configureTitle()
                    }
                    
                })
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        Single.just(menuTableView)
            .subscribe(
                onSuccess: { [self] _ in
                    guard let tableView = menuTableView else {return}
                    tableView.delegate = self
                    tableView.dataSource = self
                    menuTableView.dragInteractionEnabled = true
                    tableView.dragDelegate = self
                    tableView.dropDelegate = self
                    self.tableHeight.constant = self.menuTableView.contentSize.height
                }, onFailure: { error in
                    print(error.localizedDescription)
                })
            .disposed(by: disposeBag)
    }
    
    
    private func configureTitle() {
        guard let title = titleView else {return}
        title.layer.masksToBounds = true
        title.layer.cornerRadius = 20
        
        titleLabel.text = data?.name
        reviewValueLabel.text = String(data!.evaluation)
    }
    
    
    @IBAction func AddButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "메뉴 추가", message: "메뉴를 추가하세요", preferredStyle: .alert)
        alert.addTextField { nameTextField in
            nameTextField.placeholder = "메뉴 이름"
        }
        alert.addTextField { detailTextField in
            detailTextField.placeholder = "메뉴 설명"
        }
        alert.addTextField { priceTextField in
            priceTextField.placeholder = "메뉴 가격"
        }

        let add = UIAlertAction(title: "ADD", style: .default) { add in
            // 구현
            
            if let name = alert.textFields?[0].text, let detail = alert.textFields?[1].text, let price = alert.textFields?[2].text {
                
                TableManger.menuData.append(Menu(name: name, detail: detail, price: Int(price) ?? 0 ))
                print(detail)
                guard let tableview = self.menuTableView else { return }
                tableview.reloadData()
                
                DispatchQueue.main.async {
                    self.tableHeight.constant = self.menuTableView.contentSize.height
                }
            }
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { cancel in
            //구현
        }
        
        alert.addAction(cancel)
        alert.addAction(add)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TableManger.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "\(CellIdentifier.menuCellIdentifier)") as? MenuTableViewCell {
            let menu = TableManger.menuData[indexPath.row]
            cell.nameLabel.text = menu.name
            cell.priceLabel.text = viewModel.Decimal(menu.price) + "원'"
            cell.detailLabel.text = menu.detail
            cell.mebuImageView.image = UIImage(named: menu.name) ?? UIImage(named: "Main-한상치킨 본점")
            return cell
        }
        return UITableViewCell()
}
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        TableManger.moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension DetailViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let menus  = TableManger.menuData[indexPath.row]
        let itemProvider = NSItemProvider(object: menus)
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Menu.self)
    }
}

extension DetailViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        print("dropSessionDidUpdate start")
        
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        
        guard session.items.count == 1 else { return dropProposal }
        
        
        if tableView.hasActiveDrag {
//            if tableView.isEditing {
                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//            }
        } else {
           // 앱 바깥에서의 드래그.
           dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
    
        return dropProposal
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print("performDropWith")
        
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            // Get last index path of table view.
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: Menu.self) { items in
            //consume
            guard let menu = items as? [Menu] else { return }
            print("consuming")
            var indexPaths = [IndexPath]()
            for (index, item) in menu.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                TableManger.addItem(item, at: indexPath.row)
                indexPaths.append(indexPath)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
        
    }
    
}


