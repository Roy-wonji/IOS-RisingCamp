//
//  CoffeeTableViewCell.swift
//  StarBucksClone
//
//  Created by 서원지 on 2022/06/15.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {

    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var coffeeNameLabel: UILabel!
    @IBOutlet weak var coffeeEngNameLabel: UILabel!
    @IBOutlet weak var coffeePriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        coffeeImageView.layer.borderWidth = 1
        coffeeImageView.layer.masksToBounds = false
        coffeeImageView.layer.borderColor = UIColor.black.cgColor
        coffeeImageView.layer.cornerRadius = 100 / 2
        coffeeImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
