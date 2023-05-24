//
//  InfoTableViewCell.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit

class InfoTableViewCell: UITableViewCell {

    static let identifier = "InfoTableViewCell"
    
//MARK: - Properties
    lazy var titleLabel: UILabel = {
        $0.text = "2023년 5월 24일 테스트구요 (진행중)"
        $0.font = UIFont.notoSansBold(size: 19)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var writerLabel: UILabel = {
        $0.text = "박현준"
        $0.font = UIFont.notoSansRegular(size: 17)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var modificationDateLabel: UILabel = {
        $0.text = "2023.05.23"
        $0.font = UIFont.notoSansRegular(size: 15)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var heartImage: UIImageView = {
        $0.image = UIImage(systemName: "heart")
        $0.tintColor = .gray
        return $0
    }(UIImageView())
    
//MARK: - Life Cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUIandConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }


//MARK: - set UI
    func setUIandConstraints() {
        addSubview(titleLabel)
        addSubview(writerLabel)
        addSubview(modificationDateLabel)
        addSubview(heartImage)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
        }
        writerLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-7)
            make.leading.equalToSuperview().inset(10)
        }
        modificationDateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
        }
        heartImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(40)
        }
        
    }
}
