//
//  HeartViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit
import RealmSwift

class ScrapViewController: BaseViewController {
    
    let realm = try! Realm()
    var scrapModel: [ScrapModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
//MARK: - Properties
    private let refreshControl = UIRefreshControl()
    
    lazy var tableView: UITableView = {
        $0.separatorStyle = .none
        $0.register(ScrapTableViewCell.self, forCellReuseIdentifier: ScrapTableViewCell.identifier)
        return $0
    }(UITableView())
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        ExtesionFunc.setupNavigationBackBar(self)
        title = "Like"
        setUIandConstraints()
        modelSortedDate()
        
        refreshControl.addTarget(self, action: #selector(beginRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
//MARK: - set UI
    func setUIandConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // 날짜순으로 리스트 정렬
    func modelSortedDate() {
        let scrapData = realm.objects(ScrapModel.self)
        scrapModel = scrapData.compactMap{ $0 }
    }
    
    
//MARK: - Handler
    @objc func beginRefresh(_ sender: UIRefreshControl) {
        print("beginRefresh!")
        sender.endRefreshing()
        scrapModel.removeAll()
        modelSortedDate()
    }
    
}

extension ScrapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scrapModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScrapTableViewCell.identifier) as? ScrapTableViewCell else { return UITableViewCell() }
        let model = scrapModel[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = scrapModel[indexPath.row]
        let vc = DetailPostViewController()
        vc.title = model.category
        vc.scrapButton.isSelected = true
        vc.showScrapModel = [model]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 오른쪽 스와이프
        let delete = UIContextualAction(style: .normal, title: "delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("삭제 클릭 됨")
            try! self.realm.write {
                self.realm.delete(self.scrapModel[indexPath.row])
                self.scrapModel.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
            success(true)
        }
        delete.backgroundColor = UIColor.rgb(red: 255, green: 35, blue: 1)
        
        //actions배열 인덱스 0이 왼쪽에 붙어서 나옴
        return UISwipeActionsConfiguration(actions:[ delete ])
    }
    
}
