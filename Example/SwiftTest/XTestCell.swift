//
//  XTestCell.swift
//  SwiftTest
//
//  Created by dfpo on 04/03/2022.
//

import UIKit
class XTestCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    
     }
     func configUI() {
         contentView.backgroundColor = .yellow
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
