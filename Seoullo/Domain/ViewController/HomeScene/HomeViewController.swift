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
    
    var infoModel: [RowModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

//MARK: - Properties
    
    lazy var homeHeaderView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 420))
    
    lazy var tableView: UITableView = {
        $0.tableHeaderView = homeHeaderView
        $0.separatorStyle = .none
        $0.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return $0
    }(UITableView())
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        network()
        setUIandConstraints()
        setupNavigationBar()
    
        homeHeaderView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    func network() {
        NetworkManager.shared.employGet(1,4) { employment in
            let model = RowModel.sortDatesRowModel(employment)
            self.infoModel.append(model[0])
            self.infoModel.append(model[1])
            self.infoModel.append(model[2])
            self.infoModel.append(model[3])
        }
        NetworkManager.shared.infoCenterGet(1,4) { infoCenter in
            let model = RowModel.sortDatesRowModel(infoCenter)
            self.infoModel.append(model[0])
            self.infoModel.append(model[1])
            self.infoModel.append(model[2])
            self.infoModel.append(model[3])
        }
        NetworkManager.shared.seoulInfoGet(1,4) { seoulInfo in
            let model = RowModel.sortDatesRowModel(seoulInfo)
            self.infoModel.append(model[0])
            self.infoModel.append(model[1])
            self.infoModel.append(model[2])
            self.infoModel.append(model[3])
        }
//        NetworkManager.shared.educationGet() { edu in
//            let model = EduModel.sortDatesEduModel(edu)
//        }
    }
    
//MARK: - set UI
    func setUIandConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
//MARK: - set up Navigation Bar
    private func setupNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        let logoImageView = UIImageView(image: UIImage(named: "pointer_logo_main"))
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        logoImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        navigationItem.leftBarButtonItem = imageItem
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else { return UITableViewCell() }
        let model = RowModel.sortDatesRowModel(infoModel)[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        if let date = dateFormatter.date(from: model.UPD_DT) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let formattedDate = dateFormatter.string(from: date)
            // 셀에 대한 정보
            cell.titleLabel.text = model.TITL_NM
            cell.contentLabel.text = ExtesionFunc.stripHTMLTags(from: model.CONT)
            cell.endDateLabel.text = formattedDate
        } else {
            print("Invalid date string")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else { return }
        cell.selectionStyle = .none
        
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
        let str = "서울시 소식"
        let vc = SeoulInfoViewController()
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func infoCenterTouched() {
        let str = "자료실"
        let vc = InfoCenterViewController()
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func employTouched() {
        let str = "채용 정보"
        let vc = EmployViewController()
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func educationTouched() {
        let str = "교육 정보"
        let vc = EducationViewController()
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
}

