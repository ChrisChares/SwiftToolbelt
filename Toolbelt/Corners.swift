//
//  Corners.swift
//  Playerbook
//
//  Created by Chris Chares on 3/21/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit

public extension UIView {
    public func roundCorners(_ corners: UIRectCorner, radii: CGFloat) {
        //UIButton required this
        layer.cornerRadius = 0.0
        
        let sizeRadii = CGSize(width: radii, height: radii)
        let shapePath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: sizeRadii)
        
        let newCornerLayer = CAShapeLayer()
        newCornerLayer.frame = bounds
        newCornerLayer.path = shapePath.cgPath
        layer.mask = newCornerLayer
    }
}
