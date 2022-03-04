//
//  ViewController.swift
//  SwiftTest
//
//  Created by dfpo on 04/03/2022.
//

import UIKit
import XInjectionIII
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRealTimeRefresh()
        title = "?ffff?000dsf"
        
        view.addSubview(XTestView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        view.addSubview(XTestCell(frame: CGRect(x: 200, y: 200, width: 100, height: 100)))
    }
}

class XTestView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addRealTimeRefresh(byAction: #selector(configUI))
    }
    @objc func configUI() {
        backgroundColor = .yellow
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XTestCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    
        addRealTimeRefresh(byAction: #selector(configUI))
    }
    @objc func configUI() {
        contentView.backgroundColor = .blue
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
