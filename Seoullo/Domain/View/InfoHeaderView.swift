//
//  InfoHeaderView.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/25.
//

import UIKit
import SnapKit

protocol InfoHeaderViewDelegate: AnyObject {
    func bannerTouched()
}

class InfoHeaderView: UIView {

//MARK: - Properties
    let bannerView: UIView = {
        let imageView = UIImageView(image: UIImage(named: "banner01"))
        $0.layer.cornerRadius = 12
        $0.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return $0
    }(UIView())
    
    weak var delegate: InfoHeaderViewDelegate?
    
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

    
//MARK: - set UI
    func setUIandConstraints() {
        addSubview(bannerView)
        
        bannerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(15)
        }
    }

//MARK: - add Gesture
    func configureGesture() {
        let bannerTap = UITapGestureRecognizer(target: self, action: #selector(bannerHandler))
        bannerView.addGestureRecognizer(bannerTap)
    }
    
    @objc func bannerHandler() {
        delegate?.bannerTouched()
    }
}
