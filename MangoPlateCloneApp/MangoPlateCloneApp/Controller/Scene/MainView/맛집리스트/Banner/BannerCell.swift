//
//  BannerCell.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/07.
//

import UIKit
import Then
import SnapKit

final class BannerCell : UICollectionViewCell {
    //MARK: - Properties
    
    lazy var imageview = UIImageView().then { image in
        image.contentMode = .scaleToFill
        
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        updateViews()
        updateConstraints()
    }
    
    
    private  func updateViews() {
        self.addSubview(imageview)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        setConstraintsImageView()
    }
    
    private func setConstraintsImageView() {
        imageview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(10)
            
        }
    }
}
