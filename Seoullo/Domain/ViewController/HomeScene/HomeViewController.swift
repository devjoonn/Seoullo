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
        network() { model in
            let sortModel = RowModel.sortDatesRowModel(model)
            self.infoModel = sortModel
        }
        setUIandConstraints()
        setupNavigationBar()
    
        homeHeaderView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    func network(_ completion: @escaping ([RowModel]) -> Void) {
        var model = [RowModel]()
        
        NetworkManager.shared.employGet(1,4) { employment in
            model.append(employment[0])
            model.append(employment[1])
            model.append(employment[2])
            model.append(employment[3])
            if model.count >= 12 {
                completion(model)
            }
        }
        NetworkManager.shared.infoCenterGet(1,4) { infoCenter in
            model.append(infoCenter[0])
            model.append(infoCenter[1])
            model.append(infoCenter[2])
            model.append(infoCenter[3])
            if model.count >= 12 {
                completion(model)
            }
        }
        NetworkManager.shared.seoulInfoGet(1,4) { seoulInfo in
            model.append(seoulInfo[0])
            model.append(seoulInfo[1])
            model.append(seoulInfo[2])
            model.append(seoulInfo[3])
            if model.count >= 12 {
                completion(model)
            }
        }
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
        ExtesionFunc.setupNavigationBackBar(self)
        
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
        cell.selectionStyle = .none
        let model = RowModel.sortDatesRowModel(infoModel)[indexPath.row]
        
        // 로컬 DB 불러와 찾아서 일치하는게 있으면 좋아요 하트 들어오게
        // 중복이 되는게 있다면 네트워크 받아온다음에 중복 제거
        
        cell.configure(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailPostViewController()
        vc.title = "Lastest Post"
        vc.categoryName = "Lastest Post"
        let model = infoModel[indexPath.row]
        vc.rowModel = [model]
        navigationController?.pushViewController(vc, animated: true)
        
        
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

