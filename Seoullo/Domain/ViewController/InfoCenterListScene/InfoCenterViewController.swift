//
//  InfoCenterViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/26.
//

import UIKit
import SnapKit
import RealmSwift

class InfoCenterViewController: BaseViewController {

    private var firstPage = 1
    private var lastPage = 30
    private var isLoading = false
    
    private var spinnerView: UIView?
    let realm = try! Realm()

    
    var infoCenterModel: [RowModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
//MARK: - Properties
    let infoHeaderView = InfoHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 110))
    
    lazy var tableView: UITableView = {
        $0.tableHeaderView = infoHeaderView
        $0.separatorStyle = .none
        $0.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        return $0
    }(UITableView())
    
//MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        ExtesionFunc.setupNavigationBackBar(self)
        network()
        
        infoHeaderView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        setUIandConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

//MARK: - API Handler
    func network() {
        NetworkManager.shared.infoCenterGet(firstPage,lastPage) { seoulInfo in
            let model = RowModel.sortDatesRowModel(seoulInfo)
            self.infoCenterModel = model
        }
    }
    
    private func refetching(_ first: Int, _ last: Int,_ completion: @escaping ([RowModel]) -> Void) {
        NetworkManager.shared.infoCenterGet(first,last) { seoulInfo in
            let model = RowModel.sortDatesRowModel(seoulInfo)
            completion(model)
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

//MARK: - TableView
extension InfoCenterViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoCenterModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
        let model = infoCenterModel[indexPath.row]
        let searchPostTitle = realm.objects(ScrapModel.self).filter("title == %@", model.TITL_NM)
        //realm에 데이터가 없을 경우
        if searchPostTitle.isEmpty {
            cell.configure(model, false)
        } else {
            cell.configure(model, true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailPostViewController()
        let model = infoCenterModel[indexPath.row]
        
        vc.rowModel = [model]
        vc.title = self.title
        vc.categoryName = "Info Center"
        // Realm에서 데이터 검색
        let searchPostTitle = realm.objects(ScrapModel.self).filter("title == %@", model.TITL_NM)
        
        //realm에 데이터가 없을 경우
        if searchPostTitle.isEmpty {
            vc.scrapButton.isSelected = false
        } else {
            vc.scrapButton.isSelected = true
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 하단 로딩창
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    // 하단 셀까지 가면 셀 추가
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let postion = scrollView.contentOffset.y
        if postion > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            //fetch data
            dataFetch()
        }
    }
    
    // 데이터 불러오는 함수
    func dataFetch() {
        print("dataFetch() called - ")
        if infoCenterModel.count == 0 {
            return
        }
        
        guard !isLoading else {
            return
        }
        
        isLoading = true
        tableView.tableFooterView = createSpinnerFooter()
        
        
        
        let first = lastPage + 1
        let last = lastPage + 50
        // footerview 끄기랑 데이터 새로고침
        refetching(first, last) { model in
            self.infoCenterModel += model
            self.tableView.reloadData()
            self.isLoading = false
            self.tableView.tableFooterView = nil
        }
    }
    
    
    
}

//MARK: - InfoHeaderView Delegate
extension InfoCenterViewController: InfoHeaderViewDelegate {
    func bannerTouched() {
        print("배너 Tapped ")
    }
}
 
