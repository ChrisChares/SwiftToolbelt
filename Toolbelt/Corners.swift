//
//  Corners.swift
//  Playerbook
//
//  Created by Chris Chares on 3/21/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radii: CGFloat) {
        //UIButton required this
        layer.cornerRadius = 0.0
        
        let sizeRadii = CGSizeMake(radii, radii)
        let shapePath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: sizeRadii)
        
        let newCornerLayer = CAShapeLayer()
        newCornerLayer.frame = bounds
        newCornerLayer.path = shapePath.CGPath
        layer.mask = newCornerLayer
    }
}