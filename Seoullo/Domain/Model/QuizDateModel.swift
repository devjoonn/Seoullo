//
//  QuizDateModel.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/31.
//

import Foundation
import RealmSwift

class QuizDateModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var index: Int = 0
    @objc dynamic var day: String = ""
    
    // title 이 고유 값입니다.
    override static func primaryKey() -> String? {
      return "id"
    }
}
