//
//  RadioButtonGroup.swift
//  HuntFish
//
//  Created by Chris Chares on 2/18/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

public class Weak<T: AnyObject> {
    public weak var value: T?
    public init(value: T) {
        self.value = value
    }
}

import UIKit

public class RadioButtonGroup : UIControl {
    
    public var buttons: [Weak<UIButton>] = []
    
    public var selectedIndex : Int? = nil {
        didSet {
            self.sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    public var selectedButton: UIButton? {
        guard let selectedIndex = selectedIndex else { return nil }
        return buttons.find { $0.value?.tag == selectedIndex }?.value
    }
    
    public func addButton(button: UIButton) {
        button.tag = buttons.count
        button.addTarget(self, action: #selector(RadioButtonGroup.buttonSelected(_:)), forControlEvents: .TouchUpInside)
        buttons.append(Weak(value: button))
    }
    
    public func buttonSelected(sender: UIButton) {
        selectedIndex = sender.tag
        
        sender.selected = true
        
        buttons.filter {
            if let button = $0.value {
                return button.tag != sender.tag
            } else { return false }
            }.forEach { wrapper in
                if let button = wrapper.value {
                    button.selected = false
                }
        }
    }
}