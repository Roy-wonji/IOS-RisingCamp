//
//  MenuTableViewCell.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/25.
//

import UIKit
import RxSwift

final class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mebuImageView: UIImageView!
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        Single.just(MenuTableViewCell())
            .subscribe(
                onSuccess: { _ in
                    self.configureImageView()
                })
            .disposed(by: disposeBag)
        
    }
    
    
    private func configureImageView() {
        Single.just(mebuImageView)
            .subscribe(
                onSuccess: { _ in
                    self.mebuImageView.layer.masksToBounds = true
                    self.mebuImageView.layer.cornerRadius = 20
                })
            .disposed(by: disposeBag)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
