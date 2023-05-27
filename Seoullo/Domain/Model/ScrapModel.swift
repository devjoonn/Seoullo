//
//  ScrapModel.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/27.
//

import Foundation
import RealmSwift

class Post: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var writerOrQualification: String = ""
    @objc dynamic var updateDate: String = ""
    @objc dynamic var content: String = ""
    
    
    // id 가 고유 값입니다.
    override static func primaryKey() -> String? {
      return "id"
    }
}