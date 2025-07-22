//
//  ViewController.swift
//  SwiftTest
//
//  Created by dfpo on 04/03/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        title = "."
        
        view.addSubview(XTestView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        view.addSubview(XTestCell(frame: CGRect(x: 200, y: 700, width: 100, height: 100)))
    }
}



