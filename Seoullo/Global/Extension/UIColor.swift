//
//  UIColor.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/25.
//

import UIKit

extension UIColor {
    static let seoulloOrange = UIColor.rgb(red: 255, green: 168, blue: 92)
    static let seoulloGray = UIColor.rgb(red: 244, green: 244, blue: 244)
    static let seoulloDarkGray = UIColor.rgb(red: 185, green: 185, blue: 185)
    
}

// RGB값을 받아서 UIColor를 리턴하는 함수
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
