//
//  HomeTableViewCell.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/25.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
//MARK: - Properties
    
    
    
    //MARK: - Life Cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUIandConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUIandConstraints() {
        
    }
    
}
