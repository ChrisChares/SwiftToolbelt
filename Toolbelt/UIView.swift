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
    
    public func findSubviewOfType<T: UIView>() -> T? {
        if self is T {
            return self as? T
        }
        
        for view in subviews {
            if let result: T = view.findSubviewOfType() {
                return result
            }
        }
        return nil
    }
    
    public func printSubviews() {
        func indent(level: Int) -> String {
            let array = Array<String>(count: level, repeatedValue: "  ")
            return array.joinWithSeparator("")
        }
        func printSubviews(view: UIView, level: Int) {
            print("\(indent(level))\(view)")
            
            for subview in view.subviews {
                printSubviews(subview, level: level + 1)
            }
        }
        printSubviews(self, level: 0)
    }
}
