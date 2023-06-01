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
    private var timer: Timer?
    var infoModel: [RowModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

//MARK: - Quiz
    let quizModel: [QuizModel] = [
                                  QuizModel(title: "Q. '그런데도'와 '그런대도' 중 맞는 표현은?", leftAnswer: "그런데도", rightAnswer: "그런대도", answer: "그런데도"),
                                  QuizModel(title: "Q. '사돈'과 '사둔' 중 맞는 표현은?", leftAnswer: "사둔 어른", rightAnswer: "사돈 어른", answer: "사돈 어른"),
                                  QuizModel(title: "Q. '자살률'과 '자살율' 중 맞는 표현은?", leftAnswer: "자살률", rightAnswer: "자살율", answer: "자살률"),
                                  QuizModel(title: "Q. '어쭙잖게'와 '어줍잖게' 중 맞는 표현은?", leftAnswer: "어줍잖게", rightAnswer: "어쭙잖게", answer: "어쭙잖게"),
                                  QuizModel(title: "Q. '섭취량'과 '섭취양' 중 맞는 표현은?", leftAnswer: "섭취량", rightAnswer: "섭취양", answer: "섭취량"),
                                  QuizModel(title: "Q. '중구난방'과 '중구남방' 중 맞는 표현은?", leftAnswer: "중구난방", rightAnswer: "중구남방", answer: "중구난방"),
                                  QuizModel(title: "Q. '짭짤하다'와 '짭잘하다' 중 맞는 표현은?", leftAnswer: "짭짤하다", rightAnswer: "짭잘하다", answer: "짭짤하다"),
                                  QuizModel(title: "Q. '짝짜꿍'과 '짝짝꿍' 중 맞는 표현은?", leftAnswer: "짝짜꿍", rightAnswer: "짝짝꿍", answer: "짝짜꿍"),
                                  QuizModel(title: "Q. '일일히'와 '일일이' 중 맞는 표현은?", leftAnswer: "일일히", rightAnswer: "일일이", answer: "일일이"),
                                  QuizModel(title: "Q. '동고동락'과 '동거동락' 중 맞는 표현은?", leftAnswer: "동거동락", rightAnswer: "동고동락", answer: "동고동락"),
                                  QuizModel(title: "Q. '육개장'과 '육계장' 중 맞는 표현은?", leftAnswer: "육개장", rightAnswer: "육계장", answer: "육개장"),
                                  QuizModel(title: "Q. '뛰다시피'와 '뛰다싶이' 중 맞는 표현은?", leftAnswer: "뛰다싶이", rightAnswer: "뛰다시피", answer: "뛰다시피"),
                                  QuizModel(title: "Q. '백분율'과 '백분률' 중 맞는 표현은?", leftAnswer: "백분율", rightAnswer: "백분률", answer: "백분율"),
                                  QuizModel(title: "Q. '방방곡곡'과 '방방곳곳' 중 맞는 표현은?", leftAnswer: "방방곡곡", rightAnswer: "방방곳곳", answer: "방방곡곡"),
                                  QuizModel(title: "Q. '머릿말'과 '머리말' 중 맞는 표현은?", leftAnswer: "머릿말", rightAnswer: "머리말", answer: "머리말"),
                                  QuizModel(title: "Q. '새우젓'과 '새우젖' 중 맞는 표현은?", leftAnswer: "새우젓", rightAnswer: "새우젖", answer: "새우젓"),
                                  QuizModel(title: "Q. '찿다'와 '찾다' 중 맞는 표현은?", leftAnswer: "찾다", rightAnswer: "찿다", answer: "찾다"),
                                  QuizModel(title: "Q. '굳이'와 '구지' 중 맞는 표현은?", leftAnswer: "굳이", rightAnswer: "구지", answer: "굳이"),
                                  QuizModel(title: "Q. '뒤좇았다'와 '뒤쫓았다' 중 맞는 표현은?", leftAnswer: "뒤쫓았다", rightAnswer: "뒤좇았다", answer: "뒤쫓았다"),
                                  QuizModel(title: "Q. '새로히'와 '새로이' 중 맞는 표현은?", leftAnswer: "새로히", rightAnswer: "새로이", answer: "새로이"),
                                  QuizModel(title: "Q. '멋장이'와 '멋쟁이' 중 맞는 표현은?", leftAnswer: "멋쟁이", rightAnswer: "멋장이", answer: "멋쟁이"),
                                  QuizModel(title: "Q. '교수로서'와 '교수로써' 중 맞는 표현은?", leftAnswer: "교수로서", rightAnswer: "교수로써", answer: "교수로서"),
                                  QuizModel(title: "Q. '베짱'과 '배짱' 중 맞는 표현은?", leftAnswer: "배짱", rightAnswer: "베짱", answer: "배짱"),
                                  QuizModel(title: "Q. '해돋이'와 '해도지' 중 맞는 표현은?", leftAnswer: "해돋이", rightAnswer: "해도지", answer: "해돋이"),
                                  QuizModel(title: "Q. '살던 집'과 '살든 집' 중 맞는 표현은?", leftAnswer: "살던 집", rightAnswer: "살든 집", answer: "살던 집"),
                                  QuizModel(title: "Q. '툇마루'와 '튓마루' 중 맞는 표현은?", leftAnswer: "툇마루", rightAnswer: "튓마루", answer: "툇마루"),
                                  QuizModel(title: "Q. '오랜만에'과 '오랫만에' 중 맞는 표현은?", leftAnswer: "오랜만에", rightAnswer: "오랫만에", answer: "오랜만에"),
                                  QuizModel(title: "Q. '우려먹다'과 '울궈먹다' 중 맞는 표현은?", leftAnswer: "우려먹다", rightAnswer: "울궈먹다", answer: "우려먹다"),
                                  QuizModel(title: "Q. '흐름량'과 '흐름양' 중 맞는 표현은?", leftAnswer: "흐름량", rightAnswer: "흐름양", answer: "흐름양")
    ]
    var currentQuizIndex = 0
    var savedDay = "2023-05-31"
    
//MARK: - 어플을 켰을 때 DB에 퀴즈 모델의 index, 날짜가 저장되어있는지 판단
    private func initializeCurrentQuizIndex() {
        // Realm에서 현재의 인덱스 값을 가져옴
        let currentDate = Date() // 현재 날짜와 시간
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)

        let dateOnly = calendar.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: dateOnly!)
        
        let dateModel = realm.objects(QuizDateModel.self)
        
        if dateModel.isEmpty {
            try! realm.write {
                // 초기 데이터가 저장이 안 되어있을 시
                let quizModel = QuizDateModel()
                quizModel.id = "quiz"
                quizModel.index = 0
                quizModel.day = formattedDate
                realm.add(quizModel)
                DispatchQueue.main.async {
                    self.homeHeaderView.quizLabel.text = "Q. '그런데도'와 '그런대도' 중 맞는 표현은?"
                    self.homeHeaderView.leftAnswer.setTitle("그런데도", for: .normal)
                    self.homeHeaderView.rightAnswer.setTitle("그런대도", for: .normal)
                    self.homeHeaderView.quizAnswer = "그런데도"
                }
            }
        } else {
            // 초기 데이터가 저장이 되어있을 시
            if let quizDateModel = realm.objects(QuizDateModel.self).first {
                currentQuizIndex = quizDateModel.index
                savedDay = quizDateModel.day
                print("func currentQuiz index = \(currentQuizIndex)")
                print("func saved Day = \(savedDay)")
                updateQuiz()
            }
        }
    }
    
//MARK: -
    func updateIndexIfNeeded() -> QuizModel? {
        let currentDate = Date() // 현재 날짜와 시간
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)

        let dateOnly = calendar.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: dateOnly!)

        // DB에 저장된 데이터와 현재 날짜를 비교
        if formattedDate != savedDay {
            print("현재시간과 저장된 시간이 다름")
            currentQuizIndex += 1
            
            if currentQuizIndex > quizModel.count {
                currentQuizIndex = 0 // 배열의 마지막 인덱스 이후에는 다시 첫 번째 인덱스로 설정
                if let quizDateModel = realm.objects(QuizDateModel.self).filter("id == %@", "quiz").first {
                    try! realm.write {
                        quizDateModel.index = currentQuizIndex
                        quizDateModel.day = formattedDate
                    }
                }
            } else {
                if let quizDateModel = realm.objects(QuizDateModel.self).filter("id == %@", "quiz").first {
                    try! realm.write {
                        quizDateModel.index = currentQuizIndex
                        quizDateModel.day = formattedDate
                    }
                }
            }
        }
        return quizModel[currentQuizIndex]
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
        initializeCurrentQuizIndex()
        
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

