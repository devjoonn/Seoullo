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
    var scrapModel: Results<ScrapModel>!
    
    
//MARK: - Properties
    lazy var tableView: UITableView = {
        $0.separatorStyle = .none
        $0.register(ScrapTableViewCell.self, forCellReuseIdentifier: ScrapTableViewCell.identifier)
        return $0
    }(UITableView())
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Scrap"
        setUIandConstraints()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
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
        scrapModel = realm.objects(ScrapModel.self).sorted(byKeyPath: "updateDate", ascending: true)
    }
    
}

extension ScrapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let model = scrapModel else { return 1 }
//        return model.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScrapTableViewCell.identifier) as? ScrapTableViewCell else { return UITableViewCell() }
//        let model = scrapModel[indexPath.row]
        
//        cell.configure(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

}
