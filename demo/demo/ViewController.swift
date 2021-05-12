//
//  ViewController.swift
//  demo
//
//  Created by Phil on 2021/5/12.
//

import UIKit
import IRRadioButton_swift

class ViewController: UIViewController, IRRadioButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var rect = CGRect.init(x: 20, y: 40, width: 160, height: 25)
        let rb1 = IRRadioButton.init(frame: rect, groupId: "group0", index: 0)
        rb1.setText("A")
        self.view.addSubview(rb1)
        
        rect = CGRect.init(x: 20, y: 40 + 25 + 10, width: 160, height: 25)
        let rb2 = IRRadioButton.init(frame: rect, groupId: "group0", index: 1)
        rb2.setText("B")
        self.view.addSubview(rb2)
        
        rect = CGRect.init(x: 20, y: 40 + (25 + 10) * 2, width: 160, height: 25)
        let rb3 = IRRadioButton.init(frame: rect, groupId: "group0", index: 2)
        rb3.setText("C")
        rb3.isSelected = true
        self.view.addSubview(rb3)
        
        rect = CGRect.init(x: 20, y: 40 + (25 + 10) * 3, width: 160, height: 25)
        let rb4 = IRRadioButton.init(frame: rect, groupId: "group0", index: 3)
        rb4.setText("D")
        self.view.addSubview(rb4)
        
        rect = CGRect.init(x: 20, y: 40 + (25 + 10) * 6, width: 160, height: 25)
        let rb5 = IRRadioButton.init(frame: rect, groupId: "group1", index: 0)
        rb5.setText("1")
        rb5.isSelected = true
        self.view.addSubview(rb5)
        
        rect = CGRect.init(x: 20, y: 40 + (25 + 10) * 7, width: 160, height: 25)
        let rb6 = IRRadioButton.init(frame: rect, groupId: "group1", index: 1)
        rb6.setText("2")
        self.view.addSubview(rb6)
        
        IRRadioButton.addObserver(observer: self, groupId: "group0")
        IRRadioButton.addObserver(observer: self, groupId: "group1")
    }

    // MARK: - IRRadioButtonDelegate
    func ir_RadioButtonSelectedAtIndex(_ index: UInt, inGroup groupId: String) {
        NSLog("index:%ld, groupId:%@", index, groupId)
    }

}

