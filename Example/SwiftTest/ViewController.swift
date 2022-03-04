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
        title = "."
        
        view.addSubview(XTestView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        view.addSubview(XTestCell(frame: CGRect(x: 200, y: 200, width: 100, height: 100)))
    }
}



