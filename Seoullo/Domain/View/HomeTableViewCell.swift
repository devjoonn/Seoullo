//
//  HomeTableViewCell.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/25.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
//MARK: - Properties
    
    private let homeBackgroundView: UIView = {
        $0.backgroundColor = UIColor.seoulloGray
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())
    
    var titleLabel: UILabel = {
        $0.text = "서울시 소식"
        $0.textColor = .black
        $0.font = UIFont.notoSansBold(size: 16)
        return $0
    }(UILabel())
    
    var contentLabel: UILabel = {
        $0.text = "제목을 입력해주세요."
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(size: 12)
        return $0
    }(UILabel())

    
    var endDateLabel: UILabel = {
        $0.text = "2023.05.25"
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(size: 10)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    //MARK: - Life Cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setUIandConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUIandConstraints() {
        addSubview(homeBackgroundView)
        homeBackgroundView.addSubview(titleLabel)
        homeBackgroundView.addSubview(contentLabel)
        homeBackgroundView.addSubview(endDateLabel)
        
        homeBackgroundView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        endDateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(13)
            make.trailing.equalToSuperview().inset(14)
        }
    }
    
    func configure(_ model: RowModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        if let date = dateFormatter.date(from: model.UPD_DT) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let formattedDate = dateFormatter.string(from: date)
            // 셀에 대한 정보
            self.titleLabel.text = model.TITL_NM
            self.contentLabel.text = ExtesionFunc.stripHTMLTags(from: model.CONT)
            self.endDateLabel.text = formattedDate
        } else {
            print("Invalid date string")
        }
    }
    
}
