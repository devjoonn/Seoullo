//
//  ViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/22.
//

import UIKit
import SnapKit
import SwiftSoup

class HomeViewController: BaseViewController {

    var eduModel = [EduModel]()

//MARK: - Properties
    
    var homeHeaderView = HomeHeaderView()
    
    var tableView: UITableView = {
        $0.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
        return $0
    }(UITableView())
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        network()
        setUIandConstraints()
        setupNavigationBar()
    
        homeHeaderView.delegate = self
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
//        NetworkManager.shared.educationGet() { edu in
//            self.eduModel = edu
//            print(self.stripHTMLTags(from: self.eduModel[0].CONT) ?? "")
//        }
        
    }
    
//MARK: - set UI
    func setUIandConstraints() {
        view.addSubview(homeHeaderView)
        
        homeHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(350)
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
extension HomeViewController: HomeHeaderViewDelegate {
    
    func leftButtonTouched() {
        print("왼쪽")
    }
    
    func rightButtonTouched() {
        print("오른쪽")
    }
    
    func seoulInfoTouched() {
        print("서울 정보")
    }
    
    func infoCenterTouched() {
        print("자료실")
    }
    
    func employTouched() {
        print("채용 정보")
    }
    
    func educationTouched() {
        print("교육 정보")
    }
}

