//
//  SeoulInfoViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit

class SeoulInfoViewController: UIViewController {

    var seoulInfoModel: [RowModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
//MARK: - Properties
    private let tableView: UITableView = {
        $0.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        return $0
    }(UITableView())
    
//MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setUIandConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.shared.seoulInfoGet { seoulInfo in
            self.seoulInfoModel = seoulInfo
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
    
}

extension SeoulInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
