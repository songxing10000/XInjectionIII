//
//  XTestView.swift
//  SwiftTest
//
//  Created by dfpo on 04/03/2022.
//

import UIKit
class XTestView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addRealTimeRefresh(byAction: #selector(configUI))
    }
    @objc func configUI() {
        backgroundColor = .blue
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
