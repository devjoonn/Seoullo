//
//  ViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    
//MARK: - Properties
    let label: UILabel = {
        $0.text = "Hello world"
        $0.font = UIFont.notoSansBold(size: 20)
        $0.textAlignment = .center
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
            print("viewController = \(edu)")
        }
    }
    
//MARK: - set UI
    func setUIandConstraints() {
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
}
