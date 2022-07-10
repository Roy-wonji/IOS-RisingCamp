//
//  MusicCell.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/10.
//

import Foundation

import UIKit
import Then
import SnapKit
import RxSwift


final class MusicCell: UITableViewCell {
    //MARK: - Properties
    
    private var diseposeBag = DisposeBag()
   
    //    private let view = MusicCell()
    lazy var mainImageView = UIImageView().then { imageView in
        imageView.backgroundColor = .lightGray
    }
    
     lazy var songNameLabel  = CustomLabel(plaeceholder: "Song Name").then { label in
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    lazy var artistName = CustomLabel(plaeceholder: "artist name").then { label in
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
    }
    
    lazy var albumName = CustomLabel(plaeceholder: "album name").then { label in
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
    }
    
     lazy var releaseDate = CustomLabel(plaeceholder: "release date").then { label in
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
    }
    
    
    private lazy var stackView  = UIStackView(arrangedSubviews: [songNameLabel, artistName, albumName, releaseDate])
        .then { stack in
            stack.axis = .vertical
            stack.alignment = .fill
            stack.spacing = 10
            stack.distribution = .fill
    }
    
    var imageUrl: String? {
    
        didSet {
            loadImage()
        }
    }
    
    //MARK:  Lifcycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        
    }
    
    private func configureUI() {
        updateViews()
        updateConstraints()
    }
    
    
    private func updateViews() {
        self.addSubview(mainImageView)
        self.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage() {
        guard let urlString =  self.imageUrl , let url = URL(string: urlString) else {return}
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard urlString == url.absoluteString else { return }
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    
    
    
    
    //MARK:  - UI
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        setConstraintsMainImageView()
        setStackViewConstraints()
    }
    
    
    
    private func setConstraintsMainImageView() {
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.leading.equalTo(20)
            make.bottom.equalTo(-14)
        }
    }
    
    private func setStackViewConstraints() {
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView.snp.bottom)
            make.trailing.equalToSuperview()
            make.top.equalTo(mainImageView.snp.top)
            make.leading.equalTo(mainImageView.snp.trailing).offset(20)
        }
    }
}
