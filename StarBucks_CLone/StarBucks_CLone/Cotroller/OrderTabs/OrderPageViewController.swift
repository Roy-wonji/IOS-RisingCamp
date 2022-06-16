//
//  OrderPageViewController.swift
//  StarBucks_CLone
//
//  Created by 서원지 on 2022/06/15.
//

import UIKit

final class OrderPageViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var numOfCoffeeLabel: UILabel!
    
    var coffee: CoffeeData?
    var orderModel = OrderPageModel()
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK:  Helpers
    private func configureUI() {
        updateCoffe()
    }
    
    private func updateCoffe() {
        guard let coffee = coffee else {return}
        self.name.text = coffee.name
        orderModel.pricePerCup = coffee.price
        self.price.text = String(orderModel.pricePerCup) + "원"
        orderModel.totalPrice = coffee.price
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        orderModel.numOfCup = Int(sender.value)
        numOfCoffeeLabel.text = orderModel.numOfCup.description
        updatePriceLabel()
    }
    
    @IBAction func cupSizeChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        if index == .zero {
            orderModel.cupSize = "Tall"
            orderModel.pricePerCup = coffee?.price ?? .zero
        } else if  index == 1{
            orderModel.cupSize = "Grande"
            orderModel.pricePerCup  = (coffee?.price ?? .zero) + 600
        } else {
            orderModel.cupSize = "Venti"
            orderModel.pricePerCup = (coffee?.price ?? .zero) + 1200
        }
        print(orderModel.cupSize)
        updatePriceLabel()
    }
    
    @IBAction func cupTypeChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if index == .zero {
            orderModel.cupType = "매장컴"
        } else if index == 1 {
            orderModel.cupType = "개인컵"
        } else {
            orderModel.cupType = "일회용컵"
        }
        print(orderModel.cupType)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: CartModel.orderPushNotification)
    }
    
    private func updatePriceLabel() {
        self.orderModel.totalPrice = self.orderModel.pricePerCup * self.orderModel.numOfCup
        self.price.text = String(self.orderModel.totalPrice) + "원"
    }
}
