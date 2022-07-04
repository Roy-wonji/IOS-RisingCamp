//
//  SongTableViewCell.swift
//  LaunchPadGame
//
//  Created by GOngTAE on 2021/12/21.
//

import UIKit

final class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        albumImageView.layer.masksToBounds = true
        albumImageView.layer.cornerRadius = albumImageView.frame.height / 2
        albumImageView.layer.borderWidth = 1
        albumImageView.layer.borderColor = UIColor.gray.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            self.albumImageView.rotate()
            
        } else {
            self.albumImageView.layer.removeAllAnimations()
            
        }
    }

}
