//
//  TableViewCell.swift
//  RC_WEEK3
//
//  Created by 서원지 on 2022/06/24.
//

import UIKit
import RxSwift
import RxCocoa

final class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var orderDetailLabel: UILabel!
    
    @IBOutlet weak var deliveryIntervalLabel: UILabel!
    @IBOutlet weak var marketImageView: UIImageView!
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    
    private func configureUI() {
        Observable<UITableViewCell>.just(TableViewCell())
            .subscribe(
                onNext: {_ in
                self.configureMarketImageView()
                self.configureDeliveryIntervalLabel()
            })
            .disposed(by: disposeBag)
    }
    
    private func configureDeliveryIntervalLabel () {
        deliveryIntervalLabel.layer.masksToBounds = true
        deliveryIntervalLabel.layer.cornerRadius = 10.0
    }
    
    private func configureMarketImageView() {
        marketImageView.layer.masksToBounds = true
        marketImageView.layer.cornerRadius = 30
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
