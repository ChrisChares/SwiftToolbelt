//
//  RadioButtonGroup.swift
//  HuntFish
//
//  Created by Chris Chares on 2/18/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

class Weak<T: AnyObject> {
    weak var value: T?
    init(value: T) {
        self.value = value
    }
}

import UIKit

public class RadioButtonGroup : UIControl {
    
    var buttons: [Weak<UIButton>] = []
    
    var selectedIndex : Int? = nil {
        didSet {
            self.sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    var selectedButton: UIButton? {
        guard let selectedIndex = selectedIndex else { return nil }
        return buttons.find { $0.value?.tag == selectedIndex }?.value
    }
    
    func addButton(button: UIButton) {
        button.tag = buttons.count
        button.addTarget(self, action: #selector(RadioButtonGroup.buttonSelected(_:)), forControlEvents: .TouchUpInside)
        buttons.append(Weak(value: button))
    }
    
    func buttonSelected(sender: UIButton) {
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