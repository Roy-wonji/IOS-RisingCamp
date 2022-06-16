//
//  OrderViewController.swift
//  StarBucks_CLone
//
//  Created by 서원지 on 2022/06/15.
//

import UIKit

class OrderListViewController: UIViewController {
    //MARK:  - Properties
    
    @IBOutlet weak var coffeeTableView: UITableView!
    var coffee = CoffeModel()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configuretableVIew()
    }
    //MARK: - UI 관련
    private func configuretableVIew() {
        guard let tableview = coffeeTableView else {return}
        tableview.estimatedRowHeight = 100
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderSegue"
            ,let destination = segue.destination  as? OrderViewController
            , let coffeindex = coffeeTableView.indexPathForSelectedRow?.row
        {
            print("DEBUG: 세그성공\(destination)")
            print("\(coffeindex) has selected")
            destination.coffee = coffee.coffeeData[coffeindex]
        }
    }
}

extension OrderListViewController: UITableViewDelegate {
    
}

extension OrderListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffee.coffeeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CoffeeTableViewCell = tableView.dequeueReusableCell(withIdentifier: Cellidentifier.reuseIdentifier, for: indexPath) as! CoffeeTableViewCell
        
        if let image = coffee.coffeeData[indexPath.row].fetchImage() {
            cell.coffeeImageView.image = image
        } else {
            print("이미지 불러오기 실패")
        }
        cell.coffeeNameLabel.text = coffee.coffeeData[indexPath.row].name
        cell.coffeeEngNameLabel.text = coffee.coffeeData[indexPath.row].engName
        cell.coffeePriceLabel.text = String(coffee.coffeeData[indexPath.row].price) + "원"
        return cell
    }
}

