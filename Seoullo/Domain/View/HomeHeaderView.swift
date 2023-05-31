//
//  DailyQuizView.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit

protocol HomeHeaderViewDelegate: AnyObject {
    func leftButtonTouched(_ answer: String)
    func rightButtonTouched(_ answer: String)
    func seoulInfoTouched()
    func infoCenterTouched()
    func employTouched()
    func educationTouched()
    func visaTouched()
    func hiKoreaTouched()
    func hrdkTouched()
    func governmentTouched()
}

class HomeHeaderView: UIView {
    
    var quizAnswer = ""
    
    //MARK: - Properties
    
    private let todayLabel: UILabel = {
        let attributedString = NSMutableAttributedString(string: "Today's ", attributes: [.font: UIFont.notoSansBold(size: 16), .foregroundColor: UIColor.black])
        attributedString.append(NSMutableAttributedString(string: " Quiz", attributes: [.font: UIFont.notoSans(font: .notoSansKrBold, size: 16), .foregroundColor: UIColor.seoulloOrange]))
        $0.attributedText = attributedString
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
    
    let answerBackView: UIView = {
        $0.backgroundColor = UIColor.seoulloOrange
        $0.layer.cornerRadius = 13
        $0.alpha = 0
        return $0
    }(UIView())
    
    lazy var answerLabel: UILabel = {
        $0.text = "Answer : 접질리다"
        $0.font = UIFont.notoSansBold(size: 12)
        $0.textColor = UIColor.white
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
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
    
    lazy var categorySecondStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [self.visaStackView, self.hiKoreaStackView, self.hrdkStackView, self.governmentStackView]))
    
    let seoulInfoStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "news"))
        let str = UILabel()
        str.text = "Seoul Info"
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
        str.text = "Info Center"
        str.textColor = .black
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
        str.text = "Employ"
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
        str.text = "Education"
        str.font = UIFont.notoSansRegular(size: 10)
        $0.addArrangedSubview(image)
        $0.addArrangedSubview(str)
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    let visaStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "visa"))
        let str = UILabel()
        str.text = "Visa Potal"
        str.font = UIFont.notoSansRegular(size: 10)
        $0.addArrangedSubview(image)
        $0.addArrangedSubview(str)
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    let hiKoreaStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "hiKorea"))
        let str = UILabel()
        str.text = "Hi Korea"
        str.font = UIFont.notoSansRegular(size: 10)
        $0.addArrangedSubview(image)
        $0.addArrangedSubview(str)
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    let hrdkStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "hrdk"))
        let str = UILabel()
        str.text = "산업인력공단"
        str.font = UIFont.notoSansRegular(size: 10)
        $0.addArrangedSubview(image)
        $0.addArrangedSubview(str)
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    let governmentStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "government"))
        let str = UILabel()
        str.text = "정부 24"
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
        let visaTap = UITapGestureRecognizer(target: self, action: #selector(visaTapHandler))
        let hiKoreaTap = UITapGestureRecognizer(target: self, action: #selector(hiKoreaHandler))
        let hrdkTap = UITapGestureRecognizer(target: self, action: #selector(hrdkHandler))
        let governmentTap = UITapGestureRecognizer(target: self, action: #selector(governmentHandler))
        seoulInfoStackView.addGestureRecognizer(seoulInfoTap)
        infoCenterStackView.addGestureRecognizer(infoCenterTap)
        employStackView.addGestureRecognizer(employTap)
        educationStackView.addGestureRecognizer(educationTap)
        visaStackView.addGestureRecognizer(visaTap)
        hiKoreaStackView.addGestureRecognizer(hiKoreaTap)
        hrdkStackView.addGestureRecognizer(hrdkTap)
        governmentStackView.addGestureRecognizer(governmentTap)
    }
    
    
//MARK: - set UI
    func setUIandConstraints() {
        self.addSubview(todayLabel)
        self.addSubview(quizBackgourndView)
        quizBackgourndView.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(quizLabel)
        blurEffectView.contentView.addSubview(leftAnswer)
        blurEffectView.contentView.addSubview(rightAnswer)
        self.addSubview(answerBackView)
        answerBackView.addSubview(answerLabel)
        self.addSubview(categoryLabel)
        self.addSubview(categoryStackView)
        self.addSubview(categorySecondStackView)
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
        answerBackView.snp.makeConstraints { make in
            make.top.equalTo(quizBackgourndView.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(33)
        }
        answerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(quizBackgourndView.snp.bottom).inset(-55)
            make.leading.equalToSuperview().inset(20)
        }
        categoryStackView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        categorySecondStackView.snp.makeConstraints { make in
            make.top.equalTo(categoryStackView.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        tableViewLabel.snp.makeConstraints { make in
            make.top.equalTo(categorySecondStackView.snp.bottom).inset(-55)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
//MARK: - functuion
    @objc func leftAnswerHandler() {
        if self.leftAnswer.titleLabel?.text == self.quizAnswer {
            delegate?.leftButtonTouched("정답입니다.")
        } else {
            delegate?.leftButtonTouched("틀렸습니다.")
        }
    }
    
    @objc func rightAnswerHandler() {
        if self.rightAnswer.titleLabel?.text == self.quizAnswer {
            delegate?.rightButtonTouched("정답입니다.")
        } else {
            delegate?.rightButtonTouched("틀렸습니다.")
        }
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
    
    @objc func visaTapHandler() {
        delegate?.visaTouched()
    }
    @objc func hiKoreaHandler() {
        delegate?.hiKoreaTouched()
    }
    @objc func hrdkHandler() {
        delegate?.hrdkTouched()
    }
    @objc func governmentHandler() {
        delegate?.governmentTouched()
    }
}
