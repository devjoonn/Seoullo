//
//  employmentInput.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/22.
//

import Foundation

struct EmploymentInput: Encodable {
    var KEY: String
    var TYPE: String
    var SERVICE: String
    var START_INDEX: Int
    var END_INDEX: Int
}
