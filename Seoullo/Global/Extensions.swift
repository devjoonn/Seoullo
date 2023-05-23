//
//  Extensions.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/23.
//

import UIKit

extension String {
    var escapingHTML: String {
        let patten = "<[^>]+>|&quot;|<b>|</b>" // 필요한 패턴을 |(or기호)와 함꼐 추가하기
        
        return self.replacingOccurrences(of: patten,
                                  with: "",
                                  options: .regularExpression,
                                  range: nil)
    }
}
