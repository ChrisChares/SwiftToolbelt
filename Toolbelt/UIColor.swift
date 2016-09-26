//
//  Color.swift
//  HuntFish
//
//  Created by Chris Chares on 1/20/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit

public extension UIColor {
    /**
        Create a UIColor from a hex string.  From lucatorella's comment in https://gist.github.com/arshad/de147c42d7b3063ef7bc
        - Parameter hexString: a HexString such as "#FF0000" or "FF0000"
        - Returns: A UIColor representation of the hex string
    */
    public convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    public static func interpolate(from: UIColor, to: UIColor, fraction: Float)  -> UIColor {
        
        let f = CGFloat(min(1, max(0, fraction)))
        
        let start = CGColorGetComponents(from.CGColor)
        let end = CGColorGetComponents(to.CGColor)
        
        let r = start[0] + (end[0] - start[0]) * f
        let g = start[1] + (end[1] - start[1]) * f
        let b = start[2] + (end[2] - start[2]) * f
        let a = start[3] + (end[3] - start[3]) * f
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    public func asImage() -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context!, CGColor)
        CGContextFillRect(context!, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public func colorWithSaturation(saturation: CGFloat) -> UIColor {
        var (hue, previousSaturation, brightness, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
        getHue(&hue, saturation: &previousSaturation, brightness: &brightness, alpha: &alpha)
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    public static var random: UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
