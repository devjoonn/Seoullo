//
//  SeoulInfoViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit

class InfoViewController: BaseViewController {

//    enum dataStyle: CaseIterable {
//        case seoulInfo
//        case infoCenter
//        case employ
//        case education
//
//        switch self {
//        case .seoulInfo:
//            NetworkManager.shared.seoulInfoGet(1,4) { seoulInfo in
//                let model = RowModel.sortDatesRowModel(seoulInfo)
//            }
//        case .infoCenter:
//            NetworkManager.shared.infoCenterGet(1,4) { infoCenter in
//                let model = RowModel.sortDatesRowModel(infoCenter)
//            }
//        case .employ:
//            NetworkManager.shared.seoulInfoGet(1,4) { seoulInfo in
//                let model = RowModel.sortDatesRowModel(seoulInfo)
//            }
//        case .education:
//            NetworkManager.shared.educationGet() { edu in
//                let model = EduModel.sortDatesEduModel(edu)
//            }
//        }
//    }
    
    var seoulInfoModel: [RowModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
//MARK: - Properties
    let infoHeaderView = InfoHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 110))
    
    lazy var tableView: UITableView = {
        $0.tableHeaderView = infoHeaderView
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

//MARK: - API Handler

    
//MARK: - set UI
    func setUIandConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
 
    
//MARK: - TableView
}
extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
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
