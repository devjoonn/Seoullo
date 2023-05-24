//
//  DailyQuizView.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit

protocol DailyQuizViewDelegate: AnyObject {
    func leftButtonTouched()
    func rightButtonTouched()
}

class DailyQuizView: UIView {

//MARK: - Properties
    private let backgourndView: UIView = {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 12
        return $0
    }(UIView())
    
    private let todayLabel: UILabel = {
        $0.text = "Today's Quiz"
        $0.font = UIFont.cafe24Ssurround(size: 20)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var quizLabel: UILabel = {
        $0.text = "'접지르다'와 '접질리다' 어떤 것이 맞는 말 일까요?"
        $0.font = UIFont.notoSansRegular(size: 17)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let sideBar: UIView = {
        $0.backgroundColor = .lightGray
        return $0
    }(UIView())
    
    lazy var leftAnswer: UIButton = {
        $0.setTitle("발목을 접지르다.", for: .normal)
        $0.setTitleColor(UIColor.orange, for: .normal)
        $0.titleLabel?.font = UIFont.notoSansBold(size: 13)
        $0.addTarget(self, action: #selector(leftAnswerHandler) , for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var rightAnswer: UIButton = {
        $0.setTitle("발목을 접질리다.", for: .normal)
        $0.setTitleColor(UIColor.orange, for: .normal)
        $0.titleLabel?.font = UIFont.notoSansBold(size: 13)
        $0.addTarget(self, action: #selector(rightAnswerHandler) , for: .touchUpInside)
        return $0
    }(UIButton())
    
    weak var delegate: DailyQuizViewDelegate?
    
//MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        layer.cornerRadius = 12
        setUIandConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - set UI
    func setUIandConstraints() {
        self.addSubview(todayLabel)
        self.addSubview(quizLabel)
        self.addSubview(sideBar)
        self.addSubview(leftAnswer)
        self.addSubview(rightAnswer)
        
        todayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(15)
        }
        quizLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(todayLabel.snp.bottom).inset(-20)
        }
        sideBar.snp.makeConstraints { make in
            make.top.equalTo(quizLabel.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(50)
        }
        leftAnswer.snp.makeConstraints { make in
            make.centerY.equalTo(sideBar.snp.centerY)
            make.trailing.equalTo(sideBar.snp.leading).inset(-40)
        }
        rightAnswer.snp.makeConstraints { make in
            make.centerY.equalTo(sideBar.snp.centerY)
            make.leading.equalTo(sideBar.snp.trailing).inset(-40)
        }
    }
    
//MARK: - functuion
    @objc func leftAnswerHandler() {
        delegate?.leftButtonTouched()
    }
    
    @objc func rightAnswerHandler() {
        delegate?.rightButtonTouched()
    }
}
