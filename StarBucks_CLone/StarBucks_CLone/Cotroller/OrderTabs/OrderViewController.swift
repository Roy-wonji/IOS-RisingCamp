//
//  OrderViewController.swift
//  StarBucks_CLone
//
//  Created by 서원지 on 2022/06/15.
//

import UIKit

final class OrderViewController: UIViewController {
    //MARK: - Properties
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var engNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
var coffee: CoffeeData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func orderIsTapped(_ sender: UIButton) {
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let coffee = coffee {
            priceLabel.text = String(coffee.price) +  "원"
            nameLabel.text = coffee.name
            engNameLabel.text = coffee.engName
            imageView.image = coffee.fetchImage()
        }
    }
}


extension OrderViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "order"
            , let destination = segue.destination as? OrderPageViewController
        {
            if let coffee = coffee {
                destination.coffee = coffee
            } else {
                print("커피 데이터 에러")
            }
        }
    }
}
//
