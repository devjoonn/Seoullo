//
//  EmploymentModel.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/22.
//

import Foundation

struct NetworkModel: Codable {
    let list_total_count: Int
    let RESULT: ResultModel
    let row: [RowModel]
}

struct ResultModel: Codable {
    let CODE: String
    let MESSAGE: String
}

struct RowModel: Codable {
    let TITL_NM: String
    let CONT: String
    let WRIT_NM: String
    let LANG_GB: String
    let REG_DT: String
    let UPD_DT: String
    
    static func sortDatesRowModel(_ items: [RowModel]) -> [RowModel] {
        let sortedItems = items.sorted { $0.UPD_DT > $1.UPD_DT }
        return sortedItems
    }
}

struct EduModel: Codable {
    let LANG_GB: String //   언어
    let TITL_NM: String //   프로그램명
    let CONT: String //    내용
    let APP_ST_DT: String //    신청시작년도
    let APP_EN_DT: String //    신청마감년도
    let APP_ST_HOUR_DT: String //    신청시작시간
    let APP_EN_HOUR_DT: String //    신청마감시간
    let APP_ST_MINU_DT: String //    신청시작분
    let APP_EN_MINU_DT: String //    신청마감분
    let APP_END_YN: String //    신청마감여부
    let EDU_ST_DT: String //    교육시작년도
    let EDU_EN_DT: String //    교육마감년도
    let EDU_ST_HOUR_DT: String //    교육시작시간
    let EDU_EN_HOUR_DT: String //    교육마감시간
    let EDU_ST_MINU_DT: String //    교육시작분
    let EDU_EN_MINU_DT: String //    교육마감분
    let APP_QUAL: String //    신청자격
    let APP_WAY_ETC: String //    신청방법기타내용
    let TUIT_ETC: String //    수강료기타내용
    let PERS: String //    정원
    let REG_DT: String //    등록일자
    let UPD_DT: String //    수정일자
    
    static func sortDatesEduModel(_ items: [EduModel]) -> [EduModel] {
        let sortedItems = items.sorted { $0.UPD_DT > $1.UPD_DT }
        return sortedItems
    }
}
