//
//  RadioButtonGroup.swift
//  HuntFish
//
//  Created by Chris Chares on 2/18/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

open class Weak<T: AnyObject> {
    open weak var value: T?
    public init(value: T) {
        self.value = value
    }
}

import UIKit

open class RadioButtonGroup : UIControl {
    
    open var buttons: [Weak<UIButton>] = []
    
    open var selectedIndex : Int? = nil {
        didSet {
            self.sendActions(for: .valueChanged)
        }
    }
    
    open var selectedButton: UIButton? {
        guard let selectedIndex = selectedIndex else { return nil }
        return buttons.find { $0.value?.tag == selectedIndex }?.value
    }
    
    open func addButton(_ button: UIButton) {
        button.tag = buttons.count
        button.addTarget(self, action: #selector(RadioButtonGroup.buttonSelected(_:)), for: .touchUpInside)
        buttons.append(Weak(value: button))
    }
    
    open func buttonSelected(_ sender: UIButton) {
        guard selectedIndex != sender.tag else {
            // Don't go through the motions if this button is already selected
            return
        }
        
        selectedIndex = sender.tag
        sender.isSelected = true
        
        buttons.filter {
            if let button = $0.value {
                return button.tag != sender.tag
            } else { return false }
            }.forEach { wrapper in
                if let button = wrapper.value {
                    button.isSelected = false
                }
        }
    }
}
