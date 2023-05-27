//
//  HeartViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit
import RealmSwift

class HeartViewController: BaseViewController {
    
    let realm = try! Realm()
    
//MARK: - Properties

    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIandConstraints()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)


    }
    
//MARK: - set UI
    func setUIandConstraints() {
        
    }
    
    
    
    
}
