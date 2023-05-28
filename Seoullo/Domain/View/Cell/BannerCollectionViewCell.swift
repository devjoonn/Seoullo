//
//  BannerCollectionViewCell.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/28.
//

import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BannerCollectionViewCell"
    
    let bannerImageView: UIImageView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bannerImageView)
        
        bannerImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bannerImageView.frame = contentView.bounds
    }
    
    // 셀이보여지면 이 함수가 호출됨
    func configure(image: UIImage) {
        bannerImageView.image = image
    }
}
