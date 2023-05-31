//
//  QuizDateModel.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/31.
//

import Foundation
import RealmSwift

class QuizDateModel: Object {
    @objc dynamic var index: Int = 0
    
    
    // title 이 고유 값입니다.
    override static func primaryKey() -> String? {
      return "index"
    }
}
