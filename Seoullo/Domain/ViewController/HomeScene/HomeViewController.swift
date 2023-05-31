//
//  ViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/22.
//

import UIKit
import SnapKit
import RealmSwift

class HomeViewController: BaseViewController {
    
    let realm = try! Realm()
    var infoModel: [RowModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

//MARK: - Quiz
    let quizModel: [QuizModel] = [QuizModel(title: "Q. '부쳐지내다'과 '붙여지내다' 어떤 것이 맞는 말?", leftAnswer: "그 집에서 잠시 붙여지내고 있어.", rightAnswer: "그 집에서 잠시 부쳐지내고 있어.", answer: "그 집에서 잠시 부쳐지내고 있어."),
                                  QuizModel(title: "Q. '그런데도'와 '그런대도' 어떤 것이 맞는 말?", leftAnswer: "그런데도 지금까지 모르고 있었다니!", rightAnswer: "그런대도 지금까지 모르고 있었다니!", answer: "그런데도 지금까지 모르고 있었다니!"),
                                  QuizModel(title: "Q. '자살률'과 '자살율' 어떤 것이 맞는 말?", leftAnswer: "자살률이 낮아지고 있다.", rightAnswer: "자살율이 낮아지고 있다.", answer: "자살률이 낮아지고 있다."),
                                  QuizModel(title: "Q. '어쭙잖게'와 '어줍잖게' 어떤 것이 맞는 말?", leftAnswer: "어쭙잖게 꾀를 부린다.", rightAnswer: "어줍잖게 꾀를 부린다.", answer: "어쭙잖게 꾀를 부린다."),
                                  QuizModel(title: "Q. '섭취량'과 '섭취양' 어떤 것이 맞는 말?", leftAnswer: "하루 섭취량을 넘었습니다.", rightAnswer: "하루 섭취양을 넘었습니다.", answer: "하루 섭취량을 넘었습니다.")
    ]
    var currentQuizIndex = 0
    
    func updateIndexIfNeeded() -> QuizModel? {
        let currentDate = Date() // 현재 날짜
        
        // 매일 새로운 인덱스로 업데이트
        if !Calendar.current.isDateInToday(currentDate) {
            currentQuizIndex += 1
            print(currentQuizIndex)
            
            if self.currentQuizIndex >= self.quizModel.count {
                self.currentQuizIndex = 0 // 배열의 마지막 인덱스 이후에는 다시 첫 번째 인덱스로 설정
            }
        }
        
        return self.quizModel[currentQuizIndex]
    }
    
    func modelSortedDate() {
//        let scrapData = realm.objects(QuizDateModel.self).sorted(byKeyPath: "index", ascending: false)
    }
    
    func updateQuiz() {
        let quiz = self.updateIndexIfNeeded()
        
        DispatchQueue.main.async {
            self.homeHeaderView.quizLabel.text = quiz?.title
            self.homeHeaderView.leftAnswer.setTitle(quiz?.leftAnswer, for: .normal)
            self.homeHeaderView.rightAnswer.setTitle(quiz?.rightAnswer, for: .normal)
            self.homeHeaderView.quizAnswer = quiz?.answer ?? ""
        }
    }
    
//MARK: - Properties
    
    lazy var homeHeaderView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 550))
    
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
        updateQuiz()
        
        homeHeaderView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    func network(_ completion: @escaping ([RowModel]) -> Void) {
        var model = [RowModel]()
        
        NetworkManager.shared.employGet(1,4) { employment in
            print("a DEBUG :\(employment.count)")
            model.append(employment[0])
            model.append(employment[1])
            model.append(employment[2])
            model.append(employment[3])
            if model.count >= 12 {
                completion(model)
            }
        }
        NetworkManager.shared.infoCenterGet(1,4) { infoCenter in
            print("b DEBUG :\(infoCenter.count)")
            model.append(infoCenter[0])
            model.append(infoCenter[1])
            model.append(infoCenter[2])
            model.append(infoCenter[3])
            if model.count >= 12 {
                completion(model)
            }
        }
        NetworkManager.shared.seoulInfoGet(1,4) { seoulInfo in
            print("c DEBUG :\(seoulInfo.count)")
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
        
        let logoImageView = UIImageView(image: UIImage(named: "seoullo"))
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
    func leftButtonTouched(_ str: String) {
        UIView.animate(withDuration: 1, animations: {
            self.homeHeaderView.answerBackView.snp.makeConstraints { make in
                make.width.equalTo(100)
            }
            self.homeHeaderView.answerBackView.alpha = 0.5
            self.homeHeaderView.answerLabel.text = str
        }) { _ in
            // tableView 애니메이션
            UIView.animate(withDuration: 2, animations: {
                self.homeHeaderView.answerBackView.alpha = 0
            })
            
        }
    }
    
    func rightButtonTouched(_ str: String) {
        UIView.animate(withDuration: 1, animations: {
            self.homeHeaderView.answerBackView.snp.makeConstraints { make in
                make.width.equalTo(100)
            }
            self.homeHeaderView.answerBackView.alpha = 0.5
            self.homeHeaderView.answerLabel.text = str
        }) { _ in
            UIView.animate(withDuration: 2) {
                self.homeHeaderView.answerBackView.alpha = 0
            }
        }
    }
    
    func seoulInfoTouched() {
        let str = "Seoul Info"
        let vc = SeoulInfoViewController()
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func infoCenterTouched() {
        let str = "Info Center"
        let vc = InfoCenterViewController()
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func employTouched() {
        let str = "Employ"
        let vc = EmployViewController()
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func educationTouched() {
        let str = "Education"
        let vc = EducationViewController()
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func visaTouched() {
        let url = URL(string: "https://www.visa.go.kr/")
        let vc = WebViewController()
        vc.title = "Visa"
        vc.url = url
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func hiKoreaTouched() {
        let url = URL(string: "https://www.hikorea.go.kr/")
        let vc = WebViewController()
        vc.title = "Hi Korea"
        vc.url = url
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func hrdkTouched() {
        let url = URL(string: "https://eps.hrdkorea.or.kr/main/intro.do")
        let vc = WebViewController()
        vc.title = "산업인력공단"
        vc.url = url
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func governmentTouched() {
        let url = URL(string: "https://www.gov.kr/portal/foreigner/ko")
        let vc = WebViewController()
        vc.title = "정부 24"
        vc.url = url
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

