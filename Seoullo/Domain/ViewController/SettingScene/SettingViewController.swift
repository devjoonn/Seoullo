//
//  SettingViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit
import RealmSwift

class SettingViewController: BaseViewController {

    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
//        let searchPostTitle = realm.objects(QuizDateModel.self)
//
//        let currentDate = Date() // 현재 날짜와 시간
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
//
//        guard let dateOnly = calendar.date(from: components) else { return }
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let formattedDate = dateFormatter.string(from: dateOnly)
//
//
//        if searchPostTitle.isEmpty {
//            try! realm.write {
//                let quizModel = QuizDateModel()
//
//                quizModel.index = 0
//                quizModel.day = formattedDate
//
//                realm.add(quizModel)
//                print("add")
//            }
//        }
        
        
        
        // 아예 Realm 파일 삭제
//        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
//        let realmURLs = [
//            realmURL,
//            realmURL.appendingPathExtension("lock"),
//            realmURL.appendingPathExtension("note"),
//            realmURL.appendingPathExtension("management")
//        ]
//
//        for URL in realmURLs {
//            do {
//                try FileManager.default.removeItem(at: URL)
//            } catch {
//                // handle error
//            }
//        }
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
