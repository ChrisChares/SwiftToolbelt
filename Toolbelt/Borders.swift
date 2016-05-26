//
//  Borders.swift
//  HuntFish
//
//  Created by Chris Chares on 3/2/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit

enum BorderSide {
    case Left
    case Top
    case Right
    case Bottom
}

extension UIView {
    
    func addBorder(side: BorderSide, width: CGFloat, color: UIColor) -> CALayer {
        let layer = CALayer()
        layer.backgroundColor = color.CGColor
        layer.frame = frameForSide(side, width: width)
        self.layer.addSublayer(layer)
        return layer
    }
    
    private func frameForSide(side: BorderSide, width: CGFloat) -> CGRect {
        
        switch side {
        case .Left:
            return CGRectMake(0, 0, width, CGRectGetHeight(frame))
        case .Top:
            return CGRectMake(0, 0, CGRectGetWidth(frame), width)
        case .Right:
            return CGRectMake(CGRectGetWidth(frame), 0, width, CGRectGetHeight(frame))
        case .Bottom:
            return CGRectMake(0, CGRectGetHeight(frame), CGRectGetWidth(frame), width)
        }
    }
}
