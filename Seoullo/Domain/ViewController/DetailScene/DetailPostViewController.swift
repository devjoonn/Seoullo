//
//  DetailPostViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/26.
//

import UIKit
import SnapKit
import WebKit
import RealmSwift

class DetailPostViewController: BaseViewController {
    
    let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>"
    lazy var categoryName = ""
    
    var rowModel = [RowModel]() {
        didSet {
            guard let title = rowModel.first?.TITL_NM else { return }
            guard let writer = rowModel.first?.WRIT_NM else { return }
            guard let content = rowModel.first?.CONT else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddHHmmss"
            if let date = dateFormatter.date(from: rowModel.first?.UPD_DT ?? "") {
                dateFormatter.dateFormat = "yyyy.MM.dd"
                let formattedDate = dateFormatter.string(from: date)
                
                self.titleLabel.text = title
                self.writerOrQualification.text = writer
                self.updateDate.text = formattedDate
                self.webView.loadHTMLString(content+headerString, baseURL: nil)
                self.contentLabel.text = content
            } else {
                print("Invalid date string")
            }
        }
    }
    
    var eduModel = [EduModel]() {
        didSet {
            guard let title = eduModel.first?.TITL_NM else { return }
            guard let qualification = eduModel.first?.APP_QUAL else { return }
            guard let content = eduModel.first?.CONT else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddHHmmss"
            if let date = dateFormatter.date(from: eduModel.first?.UPD_DT ?? "") {
                dateFormatter.dateFormat = "yyyy.MM.dd"
                let formattedDate = dateFormatter.string(from: date)
                
                self.titleLabel.text = title
                self.writerOrQualification.text = qualification
                self.updateDate.text = formattedDate
                self.webView.loadHTMLString(content+headerString, baseURL: nil)
                self.contentLabel.text = content
            } else {
                print("Invalid date string")
            }
        }
    }
    
    var showScrapModel: [ScrapModel] = [] {
        didSet {
            guard let content = showScrapModel.first?.content else { return }
            self.titleLabel.text = showScrapModel.first?.title
            self.writerOrQualification.text = showScrapModel.first?.writerOrQualification
            self.updateDate.text = showScrapModel.first?.updateDate
            self.webView.loadHTMLString(content+headerString, baseURL: nil)
            self.contentLabel.text = content
        }
    }
    
    let realm = try! Realm()
    
//MARK: - Properties
    lazy var detailScrollView: UIScrollView = {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        // 이거 중요
        $0.contentSize = contentView.bounds.size
        return $0
    }(UIScrollView())
    
    lazy var contentView = UIView()
    
    private let firstLine: UIView = {
        $0.backgroundColor = UIColor.seoulloDarkGray
        return $0
    }(UIView())
    
    lazy var titleLabel: UILabel = {
        $0.text = "상세 뷰 제목"
        $0.font = UIFont.notoSansBold(size: 15)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var writerOrQualification: UILabel = {
        $0.text = "작성자: or 신청자격:"
        $0.font = UIFont.notoSansRegular(size: 11)
        $0.textColor = UIColor.seoulloDarkGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var updateDate: UILabel = {
        $0.text = "2023.05.26"
        $0.font = UIFont.notoSansRegular(size: 10)
        $0.textColor = UIColor.seoulloDarkGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    private let scrapView: UIView = {
        $0.backgroundColor = UIColor.seoulloGray
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        return $0
    }(UIView())
    
    let scrapButton: UIButton = {
        $0.setImage(UIImage(named: "unHeart"), for: .normal)
        $0.setImage(UIImage(named: "heart"), for: .selected)
        $0.addTarget(self, action: #selector(scrapHandler), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let scrapLabel: UILabel = {
        $0.text = "Like"
        $0.font = UIFont.notoSansRegular(size: 11)
        return $0
    }(UILabel())
    
    lazy var stack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 4
        return $0
    }(UIStackView(arrangedSubviews: [scrapButton, scrapLabel]))
    
    private let secondLine: UIView = {
        $0.backgroundColor = UIColor.seoulloDarkGray
        return $0
    }(UIView())

    lazy var webView: WKWebView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.scrollView.showsVerticalScrollIndicator = false
        $0.scrollView.showsHorizontalScrollIndicator = false
        $0.scrollView.isScrollEnabled = false
        $0.backgroundColor = .white
        return $0
    }(WKWebView())
    
    lazy var contentLabel: UILabel = {
        $0.text = "내용을 입력하세요."
        $0.font = UIFont.notoSansRegular(size: 13)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIandConstraints()
        ExtesionFunc.setupNavigationBackBar(self)
        self.webView.navigationDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if rowModel.count + eduModel.count + showScrapModel.count > 2 {
            rowModel.removeAll()
            eduModel.removeAll()
            showScrapModel.removeAll()
        }
    }

//MARK: - set UI
    func setUIandConstraints() {
        view.addSubview(detailScrollView)
        detailScrollView.addSubview(contentView)
        contentView.addSubview(firstLine)
        contentView.addSubview(titleLabel)
        contentView.addSubview(writerOrQualification)
        contentView.addSubview(updateDate)
        contentView.addSubview(scrapView)
        scrapView.addSubview(stack)
        contentView.addSubview(secondLine)
//        contentView.addSubview(contentLabel)
        contentView.addSubview(webView)
        
        
        detailScrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        firstLine.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.height.equalTo(0.5)
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLine.snp.bottom).inset(-15)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(23)
        }
        writerOrQualification.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-15)
            make.trailing.equalTo(scrapView.snp.leading).inset(-20)
            make.leading.equalToSuperview().inset(20)
        }
        updateDate.snp.makeConstraints { make in
            make.top.equalTo(writerOrQualification.snp.bottom).inset(-5)
            make.leading.equalToSuperview().inset(20)
        }
        scrapView.snp.makeConstraints { make in
            make.bottom.equalTo(secondLine.snp.top).inset(-15)
            make.trailing.equalToSuperview().inset(23)
            make.height.equalTo(35)
            make.width.equalTo(90)
        }
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        secondLine.snp.makeConstraints { make in
            make.top.equalTo(updateDate.snp.bottom).inset(-15)
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.centerX.equalToSuperview()
            make.height.equalTo(0.5)
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(secondLine.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(10)
//            make.height.equalTo(1600)
            // 이거 중요
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
        }
//        contentLabel.snp.makeConstraints { make in
//            make.top.equalTo(secondLine.snp.bottom).inset(-20)
//            make.leading.trailing.equalToSuperview().inset(20)
//            // 이거 중요
//            make.bottom.equalTo(contentView.snp.bottom).inset(20)
//        }
        
    }

//MARK: - WebView 이동 함수
    func pushWebView(_ url: URL){
        print("이동 webview")
        let vc = WebViewController()
        vc.url = url
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//MARK: - Handler
    @objc func scrapHandler() {
        // Realm에서 데이터 검색
        let searchPostTitle = realm.objects(ScrapModel.self).filter("title == %@",titleLabel.text ?? "")
        //realm에 데이터가 없을 경우
        if searchPostTitle.isEmpty {
            try! realm.write {
                
                let pushModel = ScrapModel()
                pushModel.id = generateNewUniqueKey()
                pushModel.title = titleLabel.text ?? ""
                pushModel.category = self.title ?? ""
                pushModel.writerOrQualification = writerOrQualification.text ?? ""
                pushModel.updateDate = updateDate.text ?? ""
                pushModel.content = contentLabel.text ?? ""
                realm.add(pushModel)
//                realm.refresh()
                // 버튼의 이미지 분기처리
                scrapButton.isSelected = true
                print("스크랩 완료")
            }
        } else {
            if let existingScrapModel = searchPostTitle.first {
                print("삭제전")
                try! realm.write {
                    realm.delete(existingScrapModel)
//                    realm.refresh()
                    // 버튼의 이미지 분기처리
                    scrapButton.isSelected = false
                    print("스크랩 삭제")
                }
            }
        }
    }
    
    // id의 uuid가 같아서 새로 생성
    func generateNewUniqueKey() -> String {
        return UUID().uuidString
    }
}

extension DetailPostViewController: WKNavigationDelegate {
    // 동적으로 webView 높이 적용
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            webView.snp.makeConstraints { make in
                make.height.equalTo(webView.scrollView.contentSize.height)
            }
        }
    }
    
    // WebView에서 링크 감지시 새로운 링크로
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            // 새로운 링크를 탭한 경우
            if navigationAction.navigationType == .linkActivated {
                pushWebView(url)
                decisionHandler(.cancel) // 링크를 열지 않도록 취소
                return
            }
        }
        
        decisionHandler(.allow) // 기본 동작 허용
    }
}
