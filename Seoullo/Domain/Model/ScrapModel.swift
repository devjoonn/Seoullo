//
//  ScrapModel.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/27.
//

import Foundation
import RealmSwift

class ScrapModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var writerOrQualification: String = ""
    @objc dynamic var updateDate: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var timeStamp: String = ""
    
    
    // title 이 고유 값입니다.
    override static func primaryKey() -> String? {
      return "id"
    }
}
