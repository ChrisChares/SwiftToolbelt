//
//  UIView.swift
//  Toolbelt
//
//  Created by Chris on 6/3/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import UIKit

public extension UIView {
    public var snapshot : UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        
        drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
