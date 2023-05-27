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
    lazy var tableView: UITableView = {
        $0.separatorStyle = .none
        $0.register(ScrapTableViewCell.self, forCellReuseIdentifier: ScrapTableViewCell.identifier)
        return $0
    }(UITableView())
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        ExtesionFunc.setupNavigationBackBar(self)
        title = "Scrap List"
        setUIandConstraints()
        modelSortedDate()
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("\(String(describing: scrapModel))")
        print("\(String(describing: scrapModel.count))")
        
        tableView.delegate = self
        tableView.dataSource = self
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
        vc.showScrapModel = [model]
        navigationController?.pushViewController(vc, animated: true)
    }

}
