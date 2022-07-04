//
//  ButtonCollectionViewCell.swift
//  LaunchPadGame
//
//  Created by GOngTAE on 2021/12/19.
//

import UIKit

final class ButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var buttonImageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                buttonImageView.image = UIImage(named: "heart")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.buttonImageView.image = UIImage(named: "BurntOrange")
                }
            } else {
                buttonImageView.image = UIImage(named: "BurntOrange")
            }
        }
    }
}
