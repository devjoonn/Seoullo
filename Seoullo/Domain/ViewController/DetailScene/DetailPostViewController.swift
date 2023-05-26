//
//  DetailPostViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/26.
//

import UIKit
import SnapKit

class DetailPostViewController: BaseViewController {

    var rowModel = [RowModel]() {
        didSet {
            self.titleLabel.text = rowModel.first?.TITL_NM
            self.writerOrQualification.text = rowModel.first?.WRIT_NM
            self.updateDate.text = rowModel.first?.UPD_DT
            self.contentLabel.text = rowModel.first?.CONT
        }
    }
    
    var eduModel = [EduModel]() {
        didSet {
            self.titleLabel.text = eduModel.first?.TITL_NM
            self.writerOrQualification.text = eduModel.first?.APP_QUAL
            self.updateDate.text = eduModel.first?.UPD_DT
            self.contentLabel.text = eduModel.first?.CONT
        }
    }
    
//MARK: - Properties
    private let detailScrollView: UIScrollView = {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        return $0
    }(UIScrollView())
    
    private let contentScrollView = UIView()
    
    private let firstLine: UIView = {
        $0.backgroundColor = UIColor.seoulloDarkGray
        return $0
    }(UIView())
    
    lazy var titleLabel: UILabel = {
        $0.text = "상세 뷰 제목"
        $0.font = UIFont.notoSansBold(size: 15)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var writerOrQualification: UILabel = {
        $0.text = "작성자: or 신청자격:"
        $0.font = UIFont.notoSansRegular(size: 11)
        $0.textColor = UIColor.seoulloDarkGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var updateDate: UILabel = {
        $0.text = "2023.05.26"
        $0.font = UIFont.notoSansRegular(size: 10)
        $0.textColor = UIColor.seoulloDarkGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    private let scrapView: UIView = {
        $0.backgroundColor = UIColor.seoulloGray
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true

        let scrapButton: UIButton = {
            let btn = UIButton()
            
            btn.setImage(UIImage(systemName:"heart"), for: .normal)
            btn.addTarget(self, action: #selector(scrapHandler), for: .touchUpInside)
            return btn
        }()
        let scrapLabel: UILabel = {
            let label = UILabel()
            label.text = "스크랩"
            label.font = UIFont.notoSansRegular(size: 11)
            return label
        }()
        let stack: UIStackView = {
            let stk = UIStackView(arrangedSubviews: [scrapButton, scrapLabel])
            stk.axis = .horizontal
            stk.distribution = .fill
            stk.spacing = 4
            return stk
        }()
        $0.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return $0
    }(UIView())
    
    private let secondLine: UIView = {
        $0.backgroundColor = UIColor.seoulloDarkGray
        return $0
    }(UIView())
    
    lazy var contentLabel: UILabel = {
        $0.text = "내용을 입력하세요."
        $0.font = UIFont.notoSansRegular(size: 13)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIandConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        rowModel.removeAll()
        eduModel.removeAll()
    }

//MARK: - set UI
    func setUIandConstraints() {
        view.addSubview(detailScrollView)
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(firstLine)
        contentScrollView.addSubview(titleLabel)
        contentScrollView.addSubview(writerOrQualification)
        contentScrollView.addSubview(updateDate)
        contentScrollView.addSubview(scrapView)
        contentScrollView.addSubview(secondLine)
        contentScrollView.addSubview(contentLabel)
        
        
        detailScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        contentScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        firstLine.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.height.equalTo(0.5)
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLine.snp.bottom).inset(-15)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(23)
        }
        writerOrQualification.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-15)
            make.leading.equalToSuperview().inset(20)
        }
        updateDate.snp.makeConstraints { make in
            make.top.equalTo(writerOrQualification.snp.bottom).inset(-5)
            make.leading.equalToSuperview().inset(20)
        }
        scrapView.snp.makeConstraints { make in
            make.top.equalTo(firstLine.snp.bottom).inset(-50)
            make.trailing.equalToSuperview().inset(23)
            make.height.equalTo(35)
            make.width.equalTo(90)
        }
        secondLine.snp.makeConstraints { make in
            make.top.equalTo(updateDate.snp.bottom).inset(-15)
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.centerX.equalToSuperview()
            make.height.equalTo(0.5)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(secondLine.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    
//MARK: - Handler
    @objc func scrapHandler() {
        print("asd")
    }
}
