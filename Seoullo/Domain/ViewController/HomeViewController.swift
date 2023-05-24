//
//  ViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/22.
//

import UIKit
import SnapKit
import SwiftSoup

class HomeViewController: UIViewController {

    var eduModel = [EduModel]()
    
    
//MARK: - Properties
    
    var dailyQuizView = DailyQuizView()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGray6
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        return cv
    }()
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        network()
        setUIandConstraints()
        setupNavigationBar()
        
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        dailyQuizView.delegate = self
    }

    
    func network() {
//        NetworkManager.shared.employGet() { employment in
//                    print("ViewController = \(employment)")
//        }
//        NetworkManager.shared.infoCenterGet() { infoCenter in
//            print("viewController = \(infoCenter)")
//        }
//        NetworkManager.shared.seoulInfoGet { seoulInfo in
//            print("viewController = \(seoulInfo)")
//        }
        NetworkManager.shared.educationGet() { edu in
//            print("viewController = \(edu)")
            self.eduModel = edu
//            self.label.text = self.stripHTMLTags(from: self.eduModel[0].CONT)
            print(self.stripHTMLTags(from: self.eduModel[0].CONT) ?? "")
        }
        
    }
    
//MARK: - set UI
    func setUIandConstraints() {
        view.addSubview(dailyQuizView)
        view.addSubview(collectionView)
        

        dailyQuizView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(180)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(dailyQuizView.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(220)
            
        }

        
    }
    
    
    func stripHTMLTags(from htmlString: String) -> String? {
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: .caseInsensitive)
        let range = NSRange(location: 0, length: htmlString.utf16.count)
        let strippedString = regex.stringByReplacingMatches(in: htmlString, options: [], range: range, withTemplate: "")
        return strippedString
    }
    
//MARK: - set up Navigation Bar
    private func setupNavigationBar() {
        let logoImageView = UIImageView(image: UIImage(named: "pointer_logo_main"))
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        logoImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        navigationItem.leftBarButtonItem = imageItem
    }
}

//MARK: - DailyQuizView Delegate
extension HomeViewController: DailyQuizViewDelegate {
    func leftButtonTouched() {
        print("왼쪽")
    }
    
    func rightButtonTouched() {
        print("오른쪽")
    }
}

//MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        let widthAndHeight = width - 15
        return CGSize(width: widthAndHeight ,height: widthAndHeight)
    }
    
}
