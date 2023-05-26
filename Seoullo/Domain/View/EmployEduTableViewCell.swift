//
//  EmployEduTableViewCell.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/26.
//

import UIKit
import SnapKit

class EmployEduTableViewCell: UITableViewCell {

    static let identifier = "EmployEduTableViewCell"
    
//MARK: - Properties
    let line: UIView = {
        $0.backgroundColor = UIColor.seoulloDarkGray
        return $0
    }(UIView())
    
    lazy var titleLabel: UILabel = {
        $0.text = "2023년 5월 26일 테스트구요 (진행중)"
        $0.font = UIFont.notoSansBold(size: 14)
        return $0
    }(UILabel())
    
    lazy var writerLabel: UILabel = {
        $0.text = "작성자명"
        $0.font = UIFont.notoSansRegular(size: 10)
        $0.textColor = UIColor.seoulloDarkGray
        return $0
    }(UILabel())
    
    let sideLine: UIView = {
        $0.backgroundColor = UIColor.seoulloDarkGray
        return $0
    }(UIView())
    
    lazy var modificationDateLabel: UILabel = {
        $0.text = "2023.05.26"
        $0.font = UIFont.notoSansRegular(size: 10)
        $0.textColor = UIColor.seoulloDarkGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let heartBackView: UIView = {
        $0.layer.cornerRadius = 23
        return $0
    }(UIView())
    
    lazy var heartImage: UIButton = {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.setImage(UIImage(systemName: "heart"), for: .selected)
        $0.tintColor = .gray
        return $0
    }(UIButton())
    
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
        addSubview(line)
        addSubview(titleLabel)
        addSubview(writerLabel)
        addSubview(sideLine)
        addSubview(modificationDateLabel)
        addSubview(heartImage)
        
        line.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(0.5)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).inset(-13)
            make.leading.equalToSuperview().inset(23)
            make.trailing.equalToSuperview().inset(55)
        }
        writerLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-12)
            make.leading.equalToSuperview().inset(23)
            make.width.equalTo(100)
        }
        sideLine.snp.makeConstraints { make in
            make.centerY.equalTo(writerLabel.snp.centerY)
            make.leading.equalTo(writerLabel.snp.trailing).inset(-8)
            make.height.equalTo(12)
            make.width.equalTo(0.5)
        }
        modificationDateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sideLine.snp.centerY)
            make.leading.equalTo(sideLine.snp.trailing).inset(-8)
        }
        heartImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(30)
            make.height.width.equalTo(20)
        }
    }
}


