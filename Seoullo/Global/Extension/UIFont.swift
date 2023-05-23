//
//  UIFonts.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/23.
//

//
//  UIFont.swift
//  PutItOn
//
//  Created by 박현준 on 2023/04/06.
//

import UIKit

enum NotoSansKRFont: CaseIterable {
    case notoSansKrBlack
    case notoSansKrBold
    case notoSansKrLight
    case notoSansKrMedium
    case notoSansKrRegular
    case notoSansKrThin
    
    var fontName: String {
        switch self {
        case .notoSansKrBlack: return "NotoSansKR-Black"
        case .notoSansKrBold: return "NotoSansKR-Bold"
        case .notoSansKrLight: return "NotoSansKR-Light"
        case .notoSansKrMedium: return "NotoSansKR-Medium"
        case .notoSansKrRegular: return "NotoSansKR-Medium"
        case .notoSansKrThin: return "NotoSansKR-Thin"
        }
    }
}

enum Cafe24SsurroundFont: CaseIterable {
    case cafe24Ssurround
    
    var fontName: String {
        switch self {
        case .cafe24Ssurround: return "Cafe24Ssurround"
        }
    }
}

extension UIFont {
    static func cafe24Ssurround(size: CGFloat) -> UIFont {
        return UIFont(name: Cafe24SsurroundFont.cafe24Ssurround.fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func notoSans(font: NotoSansKRFont, size: CGFloat) -> UIFont {
        return UIFont(name: font.fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func notoSansRegular(size: CGFloat) -> UIFont {
        return UIFont(name: NotoSansKRFont.notoSansKrRegular.fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func notoSansBold(size: CGFloat) -> UIFont {
        return UIFont(name: NotoSansKRFont.notoSansKrBold.fontName, size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}

