//
//  LocationBottomSheetView.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/11.
//

import SnapKit
import UIKit
import Then
import RxSwift

final  class LocationBottomSheetView: UIView {
    
    lazy var button = UIButton(type: .system).then { button in
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.tintColor = .darkGray
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        updateVIews()
        updateConstraints()
    }
    
    private func  updateVIews() {
        self.addSubview(button)
    }
    
    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    
    private func setConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalTo(-20)
        }
    }
}
