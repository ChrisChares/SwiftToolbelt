//
//  Constraints.swift
//  Playerbook
//
//  Created by Chris Chares on 3/29/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit


public extension UIView {
    public func deactivateAllConstraints() {
        
        // depth first
        for view in subviews {
            view.deactivateAllConstraints()
        }
        NSLayoutConstraint.deactivateConstraints(constraints)
    }
    
    public func activateAllConstraints() {
        
        // depth first
        for view in subviews {
            view.activateAllConstraints()
        }
        NSLayoutConstraint.activateConstraints(constraints)
    }
}