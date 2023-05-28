//
//  Extensions.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/23.
//

import UIKit

struct ExtesionFunc {
    
    static func stripHTMLTags(from htmlString: String) -> String? {
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: .caseInsensitive)
        let range = NSRange(location: 0, length: htmlString.utf16.count)
        let strippedString = regex.stringByReplacingMatches(in: htmlString, options: [], range: range, withTemplate: "")
        return strippedString
    }
    
    static func setupNavigationBackBar(_ viewController: UIViewController) {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .black
        viewController.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

