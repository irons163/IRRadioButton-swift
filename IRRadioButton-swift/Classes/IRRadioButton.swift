//
//  IRRadioButton.swift
//  IRRadioButton-swift
//
//  Created by Phil on 2021/5/12.
//

import Foundation
import UIKit

public protocol IRRadioButtonDelegate {
    // MARK: - optional
    func ir_RadioButtonSelectedAtIndex(_ index: UInt, inGroup groupId: String)
}

extension IRRadioButtonDelegate {
    func ir_RadioButtonSelectedAtIndex(_ index: UInt, inGroup groupId: String) {}
}

open class IRRadioButton: UIView {
    static let kRadioButtonWidth: UInt = 22
    static let kRadioButtonHeight: UInt = 22
    
    static var rb_observers: Dictionary<String, IRRadioButtonDelegate>?
    static var rb_instances: Dictionary<String, Array<IRRadioButton>>?
    
    open private(set) var radioButton: UIButton?
    open private(set) var groupId: String = ""
    open private(set) var index: UInt = 0
    open private(set) var textLbl: UILabel?
    open var isSelected: Bool = false {
        willSet {
            if newValue {
                let radioButtons = IRRadioButton.rb_instances?[self.groupId]
                for radioButton: IRRadioButton in radioButtons ?? [] {
                    if !radioButton.isEqual(self) {
                        radioButton.isSelected = false
                    }
                }
                self.radioButton?.isSelected = true
            } else {
                self.radioButton?.isSelected = false
            }
        }
    }

    // MARK: - Object Lifecycle
    public convenience init(frame: CGRect, groupId: String, index: UInt) {
        self.init(frame: frame)
        
        self.groupId = groupId
        self.index = index
        IRRadioButton.registerInstance(radioButton: self, withGroupID: self.groupId)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.radioButton = UIButton.init(type: .custom)
        self.radioButton?.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: CGFloat(IRRadioButton.kRadioButtonHeight))
        self.radioButton?.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: frame.size.width - CGFloat(IRRadioButton.kRadioButtonWidth))
        self.radioButton?.adjustsImageWhenHighlighted = false
        self.radioButton?.setImage(UIImage.imageNamedForCurrentBundle(named: "RadioButton-Unselected"), for: .normal)
        self.radioButton?.setImage(UIImage.imageNamedForCurrentBundle(named: "RadioButton-Selected"), for: .selected)
        self.radioButton?.addTarget(self, action: #selector(radioButtonClicked(sender:)), for: .touchUpInside)
        if let radioButton = self.radioButton {
            self.addSubview(radioButton)
        }
        
        let rect = CGRect.init(x: CGFloat(IRRadioButton.kRadioButtonWidth), y: 0, width: CGFloat(frame.size.width - CGFloat(IRRadioButton.kRadioButtonWidth)), height: CGFloat(IRRadioButton.kRadioButtonHeight))
        self.textLbl = UILabel.init(frame: rect)
        self.textLbl?.font = UIFont.systemFont(ofSize: 15)
        self.textLbl?.backgroundColor = .clear
        if let textLbl = self.textLbl {
            self.addSubview(textLbl)
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Manage Instances
    class func registerInstance(radioButton: IRRadioButton, withGroupID aGroupID: String) {
        if (rb_instances == nil) {
            rb_instances = Dictionary.init()
        }
        
        var radioButtons = rb_instances?[aGroupID]
        if (radioButtons != nil) {
            radioButtons?.append(radioButton)
        } else {
            radioButtons = Array.init()
            radioButtons?.append(radioButton)
        }
        
        rb_instances?[aGroupID] = radioButtons
    }
    
    // MARK: - Set RadioButton Value
    open func setText(_ text: String) {
        self.textLbl?.text = text
    }
    
    // MARK: - Tap handling
    @objc func radioButtonClicked(sender: UIButton) {
        self.isSelected = true
        
        if (IRRadioButton.rb_observers != nil) {
            let observer = IRRadioButton.rb_observers?[self.groupId]
            observer?.ir_RadioButtonSelectedAtIndex(self.index, inGroup: self.groupId)
        }
    }
    
    // MARK: - Observer
    open class func addObserver(observer: IRRadioButtonDelegate, groupId: String) {
        if (rb_observers == nil) {
            rb_observers = Dictionary.init()
        }
        
        if groupId.count > 0 {
            rb_observers?[groupId] = observer
        }
    }
    
    open class func removeObserver(groupId: String) {
        rb_instances?[groupId]?.removeAll()
    }
    
    open class func removeAllObserver() {
        rb_observers?.removeAll()
        rb_instances?.removeAll()
        
        rb_instances = nil
        rb_observers = nil
    }
    
}
