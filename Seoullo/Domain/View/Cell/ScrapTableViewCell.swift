//
//  ScrapTableViewCell.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/27.
//

import UIKit
import SnapKit

class ScrapTableViewCell: UITableViewCell {

    static let identifier = "ScrapTableViewCell"
    
//MARK: - Properties
    let line: UIView = {
        $0.backgroundColor = UIColor.seoulloDarkGray
        return $0
    }(UIView())
    
    lazy var categoryLabel: UILabel = {
        $0.text = "채용 정보"
        $0.font = UIFont.notoSansBold(size: 14)
        return $0
    }(UILabel())
    
    lazy var titleLabel: UILabel = {
        $0.text = "제목을 입력해주세요"
        $0.font = UIFont.notoSansRegular(size: 10)
        $0.textColor = UIColor.seoulloDarkGray
        return $0
    }(UILabel())
    
    lazy var modificationDateLabel: UILabel = {
        $0.text = "2023.05.27"
        $0.font = UIFont.notoSansRegular(size: 10)
        $0.textColor = UIColor.seoulloDarkGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var heartImage: UIButton = {
        $0.setImage(UIImage(named: "tableHeart"), for: .normal)
        return $0
    }(UIButton())
    
    
//MARK: - Life Cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setUIandConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
//MARK: - set UI
    
    func setUIandConstraints()  {
        addSubview(line)
        addSubview(categoryLabel)
        addSubview(titleLabel)
        addSubview(modificationDateLabel)
        addSubview(heartImage)
        
        line.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(0.5)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).inset(-8)
            make.leading.equalToSuperview().inset(23)
            make.trailing.equalToSuperview().inset(55)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-12)
            make.leading.trailing.equalToSuperview().inset(23)
        }
        modificationDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-5)
            make.leading.equalToSuperview().inset(23)
        }
        heartImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(30)
            make.height.width.equalTo(26)
        }
    }
    
    func configure(_ model: ScrapModel) {
        categoryLabel.text = model.category
        titleLabel.text = model.title
        modificationDateLabel.text = model.updateDate
    }
}
