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
    
    lazy var writerOrQualificationLabel: UILabel = {
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
        $0.setImage(UIImage(named: "tableUnHeart"), for: .normal)
        $0.setImage(UIImage(named: "tableHeart"), for: .selected)
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
        addSubview(writerOrQualificationLabel)
        addSubview(sideLine)
        addSubview(modificationDateLabel)
        addSubview(heartImage)
        
        line.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(0.5)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).inset(-17)
            make.leading.equalToSuperview().inset(23)
            make.trailing.equalToSuperview().inset(55)
        }
        writerOrQualificationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-15)
            make.leading.equalToSuperview().inset(23)
            make.width.equalTo(100)
        }
        sideLine.snp.makeConstraints { make in
            make.centerY.equalTo(writerOrQualificationLabel.snp.centerY)
            make.leading.equalTo(writerOrQualificationLabel.snp.trailing).inset(-8)
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
    
    func configure( eduModel: EduModel?, rowModel: RowModel?, _ scrap: Bool) {
        if rowModel != nil {
            guard let model = rowModel else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: model.UPD_DT) {
                dateFormatter.dateFormat = "yyyy.MM.dd"
                let formattedDate = dateFormatter.string(from: date)
                // 셀에 대한 정보
                self.titleLabel.text = model.TITL_NM
                self.modificationDateLabel.text = formattedDate
                self.writerOrQualificationLabel.text = model.WRIT_NM
                self.heartImage.isSelected = scrap
            } else {
                print("Invalid date string")
            }
        } else {
            guard let eduModel = eduModel else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddHHmmss"
            if let date = dateFormatter.date(from: eduModel.UPD_DT) {
                dateFormatter.dateFormat = "yyyy.MM.dd"
                let formattedDate = dateFormatter.string(from: date)
                // 셀에 대한 정보
                self.titleLabel.text = eduModel.TITL_NM
                self.modificationDateLabel.text = formattedDate
                self.writerOrQualificationLabel.text = eduModel.APP_QUAL
                self.heartImage.isSelected = scrap
            } else {
                print("Invalid date string")
            }
        }
    }
}


