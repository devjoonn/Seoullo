//
//  DailyQuizView.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit

protocol HomeHeaderViewDelegate: AnyObject {
    func leftButtonTouched()
    func rightButtonTouched()
    func seoulInfoTouched()
    func infoCenterTouched()
    func employTouched()
    func educationTouched()
}

class HomeHeaderView: UIView {
    
    //MARK: - Properties
    
    private let todayLabel: UILabel = {
        $0.text = "Today's Quiz"
        $0.font = UIFont.notoSansBold(size: 16)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let quizBackgourndView: UIView = {
        $0.layer.cornerRadius = 12
        let imageView = UIImageView(image: UIImage(named: "quizBack"))
        
        $0.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return $0
    }(UIView())
    
    private let blurEffectView: UIVisualEffectView = {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 14
        return $0
    }(UIVisualEffectView(effect: UIBlurEffect(style: .light)))
    
    lazy var quizLabel: UILabel = {
        $0.text = "Q. '접지르다'와 '접질리다' 중 맞는 표현은?"
        $0.font = UIFont.notoSansRegular(size: 13)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    lazy var leftAnswer: UIButton = {
        $0.setTitle("발목을 접지르다.", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.notoSansRegular(size: 11)
        $0.addTarget(self, action: #selector(leftAnswerHandler) , for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var rightAnswer: UIButton = {
        $0.setTitle("발목을 접질리다.", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.notoSansRegular(size: 11)
        $0.addTarget(self, action: #selector(rightAnswerHandler) , for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let categoryLabel: UILabel = {
        $0.text = "Category"
        $0.font = UIFont.notoSansBold(size: 16)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var categoryStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [self.seoulInfoStackView, self.infoCenterStackView, self.employStackView, self.educationStackView]))
    
    let seoulInfoStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "news"))
        let str = UILabel()
        str.text = "서울시 소식"
        str.font = UIFont.notoSansRegular(size: 10)
        $0.addArrangedSubview(image)
        $0.addArrangedSubview(str)
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    let infoCenterStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "infoCenter"))
        let str = UILabel()
        str.text = "자료실"
        str.font = UIFont.notoSansRegular(size: 10)
        $0.addArrangedSubview(image)
        $0.addArrangedSubview(str)
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    let employStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "employ"))
        let str = UILabel()
        str.text = "채용 정보"
        str.font = UIFont.notoSansRegular(size: 10)
        $0.addArrangedSubview(image)
        $0.addArrangedSubview(str)
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    let educationStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "education"))
        let str = UILabel()
        str.text = "교육 정보"
        str.font = UIFont.notoSansRegular(size: 10)
        $0.addArrangedSubview(image)
        $0.addArrangedSubview(str)
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    let tableViewLabel: UILabel = {
        let attributedString = NSMutableAttributedString(string: "Current ", attributes: [.font: UIFont.notoSansBold(size: 16), .foregroundColor: UIColor.black])
        attributedString.append(NSMutableAttributedString(string: "Latest ", attributes: [.font: UIFont.notoSans(font: .notoSansKrBold, size: 16), .foregroundColor: UIColor.seoulloOrange]))
        attributedString.append(NSMutableAttributedString(string: "Post", attributes: [.font: UIFont.notoSans(font: .notoSansKrBold, size: 16), .foregroundColor: UIColor.black]))
        $0.attributedText = attributedString
        return $0
    }(UILabel())
    
    
    weak var delegate: HomeHeaderViewDelegate?
    
//MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUIandConstraints()
        configureGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - UI Gesture
    func configureGesture() {
        let seoulInfoTap = UITapGestureRecognizer(target: self, action: #selector(seoulInfoHandler))
        let infoCenterTap = UITapGestureRecognizer(target: self, action: #selector(infoCenterHandler))
        let employTap = UITapGestureRecognizer(target: self, action: #selector(employHandler))
        let educationTap = UITapGestureRecognizer(target: self, action: #selector(educationHandler))
        seoulInfoStackView.addGestureRecognizer(seoulInfoTap)
        infoCenterStackView.addGestureRecognizer(infoCenterTap)
        employStackView.addGestureRecognizer(employTap)
        educationStackView.addGestureRecognizer(educationTap)
    }
    
    
//MARK: - set UI
    func setUIandConstraints() {
        self.addSubview(todayLabel)
        self.addSubview(quizBackgourndView)
        quizBackgourndView.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(quizLabel)
        blurEffectView.contentView.addSubview(leftAnswer)
        blurEffectView.contentView.addSubview(rightAnswer)
        self.addSubview(categoryLabel)
        self.addSubview(categoryStackView)
        self.addSubview(tableViewLabel)
        
        todayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(20)
        }
        quizBackgourndView.snp.makeConstraints { make in
            make.top.equalTo(todayLabel.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
        blurEffectView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(30)
        }
        quizLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(23)
        }
        leftAnswer.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(30)
        }
        rightAnswer.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(30)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(quizBackgourndView.snp.bottom).inset(-35)
            make.leading.equalToSuperview().inset(20)
        }
        categoryStackView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        tableViewLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryStackView.snp.bottom).inset(-35)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
//MARK: - functuion
    @objc func leftAnswerHandler() {
        delegate?.leftButtonTouched()
    }
    
    @objc func rightAnswerHandler() {
        delegate?.rightButtonTouched()
    }
    
    @objc func seoulInfoHandler() {
        delegate?.seoulInfoTouched()
    }
    
    @objc func infoCenterHandler() {
        delegate?.infoCenterTouched()
    }
    
    @objc func employHandler() {
        delegate?.employTouched()
    }
    
    @objc func educationHandler() {
        delegate?.educationTouched()
    }
}
