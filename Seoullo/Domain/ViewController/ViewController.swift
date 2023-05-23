//
//  ViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/22.
//

import UIKit
import SnapKit
import SwiftSoup

class ViewController: UIViewController {

    var eduModel = [EduModel]()
    
    
//MARK: - Properties
    let label: UILabel = {
        $0.text = "Hello world"
        $0.font = UIFont.notoSansBold(size: 10)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        network()
        setUIandConstraints()
    }

    
    func network() {
//        NetworkManager.shared.employGet() { employment in
//                    print("ViewController = \(employment)")
//        }
//        NetworkManager.shared.infoCenterGet() { infoCenter in
//            print("viewController = \(infoCenter)")
//        }
//        NetworkManager.shared.seoulInfoGet { seoulInfo in
//            print("viewController = \(seoulInfo)")
//        }
        NetworkManager.shared.educationGet() { edu in
//            print("viewController = \(edu)")
            self.eduModel = edu
        }
        
    }
    
//MARK: - set UI
    func setUIandConstraints() {
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
        
    }
    
    func stripHTMLTags(from htmlString: String) -> String {
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: .caseInsensitive)
        let range = NSRange(location: 0, length: htmlString.utf16.count)
        let strippedString = regex.stringByReplacingMatches(in: htmlString, options: [], range: range, withTemplate: "")
        return strippedString
    }
}
