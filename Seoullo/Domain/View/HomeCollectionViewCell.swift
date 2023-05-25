//
//  HomeCollectionViewCell.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    
//    var item: HomeCollectionItem {
//        didSet {
//            configure()
//        }
//    }
    
//MARK: - Properties
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
        addSubview(infoImage)
        addSubview(infoLabel)
        
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
    
//MARK: - Functions
//    func configure() {
//        let item = item
//        infoImage.image = item.image
//        infoLabel.text = item.infoString
//    }
}
