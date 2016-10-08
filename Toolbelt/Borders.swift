//
//  Borders.swift
//  HuntFish
//
//  Created by Chris Chares on 3/2/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit

public enum BorderSide {
    case left
    case top
    case right
    case bottom
}

public extension UIView {
    
    public func addBorder(_ side: BorderSide, width: CGFloat, color: UIColor) -> CALayer {
        let layer = CALayer()
        layer.backgroundColor = color.cgColor
        layer.frame = frameForSide(side, width: width)
        self.layer.addSublayer(layer)
        return layer
    }
    
    fileprivate func frameForSide(_ side: BorderSide, width: CGFloat) -> CGRect {
        
        switch side {
        case .left:
            return CGRect(x: 0, y: 0, width: width, height: frame.height)
        case .top:
            return CGRect(x: 0, y: 0, width: frame.width, height: width)
        case .right:
            return CGRect(x: frame.width, y: 0, width: width, height: frame.height)
        case .bottom:
            return CGRect(x: 0, y: frame.height, width: frame.width, height: width)
        }
    }
}
