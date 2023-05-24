//
//  HomeCollectionViewCell.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {

    static let identifier = "HomeCollectionViewCell"
    
    var collectionBackgroundView: UIView = {
        $0.backgroundColor = .systemGray5
        $0.layer.cornerRadius = 15
        return $0
    }(UIView())
    
    var infoImage: UIImageView = {
        $0.image = UIImage(systemName: "heart")
        $0.tintColor = .white
        return $0
    }(UIImageView())
    
    var infoLabel: UILabel = {
        $0.text = "정보"
        $0.font = UIFont.notoSansBold(size: 14)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    
//MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUIandConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - set UI
    func setUIandConstraints() {
        addSubview(collectionBackgroundView)
        collectionBackgroundView.addSubview(infoImage)
        collectionBackgroundView.addSubview(infoLabel)
        
        collectionBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        infoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(17)
            make.height.width.equalTo(43)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(infoImage.snp.bottom).inset(-8)
            make.centerX.equalToSuperview()
        }
    }
}
